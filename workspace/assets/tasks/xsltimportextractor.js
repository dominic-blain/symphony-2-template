'use strict';

module.exports = function xsltimportextractor (grunt) {
	// Set default config
	grunt.config.merge({
		xsltimportextractor: {
			options: {
				pagesPath: '../pages/*.xsl',
				allowFilesNotFound: true
			}
		}
	});

	grunt.registerTask('xsltimportextractor', 'Builds a list of all used xslt files', function () {
		var options = this.options();
		var libxmljs = require('libxmljs');
		var pages = grunt.file.expand(options.pagesPath);
		var files = {};
		var finalFiles = [];
		var basePath = '';
		var level = 0;

		var processPage = function (f) {
			//Template list

			var processFile = function (f) {

				var oldBasePath = basePath;

				var processImports = function (item) {
					//Lookup href
					var href = item.attr('href').value();

					processFile(href);
				};

				//Append files
				var lastSlash = f.lastIndexOf('/');
				
				if (lastSlash !== -1) {
					//Check Truncate

					if (basePath.length === 0) {
						basePath += f.substring(0, lastSlash + 1);

					} else if (f.startsWith('../')) {
						var countRemove = 0;

						f.split('/').forEach(function (ff) {
							if (ff == '..') {
								countRemove += 1;
							}
						});

						//Truncate a part
						var splittedBasePath = basePath.split('/');

						if (splittedBasePath.length > 1) {
							var newBasePath = '';
							var x = 1;

							splittedBasePath.forEach(function (item) {
								if (x == 1) {
									//always keep first ../
									newBasePath += item + '/';
									x += 1;
								} else if (splittedBasePath.length - x > countRemove) {
									newBasePath += item + '/';
									x += 1;
								}
							});

							//Fix ../ if not enough
							while (x < countRemove) {
								newBasePath += '../';
								x += 1;
							}
							basePath = newBasePath + f.substring(countRemove * 3, lastSlash + 1);
						}
					} else {
						//Append
						basePath += f.substring(0, lastSlash + 1);
					}

				}

				var fixedFilePath = basePath + f.substring(lastSlash + 1);

				if (!!!files[fixedFilePath] && fixedFilePath.indexOf('ui-toolkit') === -1) {
					files[fixedFilePath] = fixedFilePath;
					level += 1;

					finalFiles.push({src: fixedFilePath, level: level});

					if (grunt.file.exists(fixedFilePath)) {
						var xml = grunt.file.read(fixedFilePath);

						var xmlDoc = libxmljs.parseXmlString(xml);
						var imports = xmlDoc.find('//xsl:import', {xsl: 'http://www.w3.org/1999/XSL/Transform'});

						if (imports) {
							imports.forEach(processImports);
						}
					} else {
						(options.allowFilesNotFound ?
							grunt.verbose.writeln :
							grunt.fail.fatal
						)('Error: File not found: ' + fixedFilePath);
					}
					
					level -= 1;
				}
				basePath = oldBasePath;
			};
			processFile(f);
		};

		pages.forEach(processPage);

		//Print
		finalFiles.forEach(function (item) {
			grunt.log.write('(' + item.level + ') ');
			for (var i = 0; i < item.level; i++) {
				grunt.log.write('  ');
			}
			grunt.log.writeln(item.src);
		});
		
		grunt.config.set('xsltimportextrator.files.unique', finalFiles);
	});
};
