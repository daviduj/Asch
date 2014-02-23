<?php

class Search extends CI_Controller {

	public function index (){

		//echo "Search Manager";

		$data['pagina'] = 'pagina principal';
		$this->load->view('search',$data);

	}


} 

?>