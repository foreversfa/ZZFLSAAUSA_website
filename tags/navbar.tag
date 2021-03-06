<navbar>
	<!-- Always shows a header, even in smaller screens. -->
	<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
	  <header class="mdl-layout__header my-header">
	    <div class="mdl-layout__header-row">
	      <!-- Title -->
	      <span class="mdl-layout-title">ZZFLS AAUSA</span>
	      <!-- Add spacer, to align navigation to the right -->
	      <div class="mdl-layout-spacer"></div>
	      <!-- Navigation. We hide it in small screens. -->
	      <nav class="mdl-navigation mdl-layout--large-screen-only">
		      <a class="mdl-navigation__link" href="#">Homepage</a>
		      <a class="mdl-navigation__link" href="#">Name Board</a>
		      <!-- <a class="mdl-navigation__link" href="">knowledge</a> -->
		      <a if={!loggedIn} class="mdl-navigation__link" href="#" onclick={showLogin}>Log In | Sign Up</a>
		      <a if={loggedIn} class="mdl-navigation__link" href="#" onclick={logOut}>Log Out</a>
		      <a if={loggedIn} class="mdl-navigation__link" href="#personal" > <img class="head-icon" src="https://cdn0.iconfinder.com/data/icons/superuser-web-kit/512/686909-user_people_man_human_head_person-512.png" alt=""></a>


	      </nav>
	    </div>
	  </header>
	  
	  
	</div>

	<script>
	var that = this;
	that.loggedIn = that.opts.loggedIn;

	that.logOut = function(e){
		Parse.User.logOut();
		document.location.href="/";

	}

	that.showLogin = function(e){
		riot.mount('#Login','logsign');
	}

	</script>
  <style scoped>
    :scope 
    /*.mdl-layout__header{
		background-color: red !important; 
	}*/
	.mdl-layout--fixed-header{
		height: 70px !important;
	}

	.my-header{
		background-color: #424242;
	}
	.head-icon{
		border-radius: 50%;
		width:30px;
		margin-left: -20px;
	}

  </style>

</navbar>

