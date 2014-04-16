<?php

	require_once(DATASOURCES . '/lib/class.json.datasource.php');

	Class datasourcejavascript extends JSONDataSource {

		public $dsParamROOTELEMENT = 'javascript';

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Javascript',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'http://deuxhutihuit.com',
					'email' => 'open-source@deuxhuithuit.com'),
				'version' => 'Symphony 2.3.6',
				'release-date' => '2014-03-12T19:25:30+00:00'
			);
		}

		public function getSource() {
			return 'js.json';
		}

		protected function getJSONFilePath() {
			return WORKSPACE . '/assets/js.json';
		}
		
		protected function decode(XMLElement &$result, array $json) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			foreach ($json as $index => $file) {
				$result->appendChild(new XMLElement('file', $file));
			}
			
			return $result;
		}

	}
