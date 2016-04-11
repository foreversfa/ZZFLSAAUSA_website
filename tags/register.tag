<register>
<!-- source code copyright from Atakan Goktepe http://codepen.io/atakan/pen/gqbIz -->
	<div class="register-wrap">
		<form class="register-form">
			<ul id="progressbar">
			    <li class="active">Create Account</li>
			    <li>Personal Info</li>
			</ul>
		
			<fieldset>
			    <h2 class="title">Create your account</h2>
			    <h3 if={errorMessage} class="errorMessage">{errorMessage}</h3>
			    <input type="text" name="email" placeholder="Email" />
			    <input type="password" name="pass" placeholder="Password" />
			    <input type="password" name="cpass" placeholder="Confirm Password" />
			    <input type="button" name="next" class="next action-button" value="Next" id="register"/>
			</fieldset >
			
			<fieldset>
			    <h2 class="title">Input personal info</h2>
			    <h3 class="subtitle">Your account has not been created yet. In order to keep the confidentiality of our site, we have to verify that you graduated from ZZFLS. Your information will not become public yet. The info you enter here is for examination purpose. Please answer as many questions as you can.</h3>
			    <input type="text" name="fullname" placeholder="Full Name" />
			    <input name="bday" placeholder="Birthday" type="text" onfocus="(this.type='date')"> 
			    
			    <select class="form-control">
			    	<option value="female">Female</option>
			    	<option value="male">Male</option>
			    	<option value="other">Other</option>
			    </select>
			    <input type="text" name="graduationYear" placeholder="Graduation Year from ZZFLS" />
			    <input type="text" name="counsellor" placeholder="Class Counsellor" />
			    <input type="text" name="city" placeholder="Current City" />
			    <input type="text" name="job" placeholder="Current Company/School name" />
			    

			    <input type="button" name="next" class="next action-button" value="Finish" id="personal"/>
			</fieldset>

		
		</form>
	</div>
	
	<script>
	
	var that = this;

	if(Parse.User.current()){
		window.location.replace("/#");
	}


	that.register = function(callback){
		//create a Parse promise object
		var promise = new Parse.Promise();
		var usrname = that.email.value;

		
		
		if(that.pass.value == that.cpass.value){
		
			var user = new Parse.User();

	        user.set("username", that.email.value);
	        user.set("password", that.pass.value);
	        user.set("email", that.email.value);
			user.signUp().then(function(user){
				promise.resolve(user);
			}, function(error){
				promise.reject(error);
			})	
		}
		else{
			that.errorMessage = "Two passwards not confirm.";
			that.pass.value = that.cpass.value = "";
			riot.update();
			promise.reject(that.errorMessage);
			

		}

		return promise;

		
	};

	that.moveToNext = function(current_fs,next_fs){
		var left, opacity, scale; //fieldset properties which we will animate
		var animating; //flag to prevent quick multi-click glitches

		//activate next step on progressbar using the index of next_fs
		$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
	
		//show the next fieldset
		next_fs.show(); 
		//hide the current fieldset with style
		current_fs.animate({opacity: 0}, {
			step: function(now, mx) {
				//as the opacity of current_fs reduces to 0 - stored in "now"
				//1. scale current_fs down to 80%
				scale = 1 - (1 - now) * 0.2;
				//2. bring next_fs from the right(50%)
				left = (now * 50)+"%";
				//3. increase opacity of next_fs to 1 as it moves in
				opacity = 1 - now;
				current_fs.css({
	        'transform': 'scale('+scale+')',
	        'position': 'absolute'
	      	});
				next_fs.css({'left': left, 'opacity': opacity});
			}, 
			duration: 800, 
			complete: function(){
				current_fs.hide();
				animating = false;
			}, 
			//this comes from the custom easing plugin
			easing: 'easeInOutBack'
		});
	}


	that.one('updated',function(){

		//jQuery has to go into updated function
		//first need to check which step is currently on
		$(".next").click(function(){
			var $pane = $(this);
			console.log(that.bday.value)
			//if user is registering account
			if($pane.attr('id') == 'register'){
				//register. use deffered
				
				that.register().then(function(user){
					that.moveToNext($pane.parent(),$pane.parent().next())
					}, function(error){
			      		that.errorMessage = "Email address aleady exists."
			      		that.email.value = that.pass.value = that.cpass.value = "";
			      		riot.update();
				});

			}
			
			else{
				var user = Parse.User.current().toJSON();
				var Infos = Parse.Object.extend('Infos')
				var newinfo = new Infos();
				newinfo.set({
					fullname:{fullname:that.fullname.value,public:true},
					bday:{bday:that.bday.value,public:false},
					sex:{sex:$('select option:selected').val(),public:false},
					gradyear:{gradyear:that.graduationYear.value,public:true},
					classcounsellor:{classcounsellor:that.counsellor.value,public:false},
					currentcity:{currentjob:that.job.value,public:false},
					currentjob:{currentjob:that.job.value,public:false},
					email:{email:user.email,public:true}
				})
				
				newinfo.save().then(function(){
					that.moveToNext($(this).parent(),$(this).parent().next());
					window.location.reload();
				});
				
			}
		})
			

	})



	</script>
	
	<style scoped>
	:scope{
		/*background-image: url('http://www.pixeden.com/media/k2/galleries/165/003-subtle-light-pattern-background-texture-vol5.jpg');*/
		margin-top: -11px;
		height: 550px;
	};
	

	fieldset {
		background: white;
		border: 1px solid black;
		border-radius: 3px;
		/*box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4);*/
		padding: 20px 30px;
		box-sizing: border-box;
		width: 80%;
		margin: 0 12.5%;
		
		/*stacking fieldsets above each other*/
		position: relative;
	}
	/*input box*/
	fieldset input, fieldset textarea {
		padding: 15px;
		border: 1px solid #ccc;
		border-radius: 3px;
		margin-bottom: 10px;
		width: 100%;
		box-sizing: border-box;
		/*font-family: montserrat;*/
		color: #2C3E50;
		font-size: 13px;
	}

	fieldset select{
		margin-bottom: 10px;
		border: 1px solid #ccc;
		border-radius: 3px;
	}
	/*buttons*/
	fieldset .action-button {
		width: 100px;
		background: #27AE60;
		font-weight: bold;
		color: white;
		border: 0 none;
		border-radius: 1px;
		cursor: pointer;
		padding: 10px 5px;
		margin: 10px 5px;
	}
	
	fieldset:not(:first-of-type) {
	display: none;
	}

	fieldset .action-button:hover, fieldset .action-button:focus {
		box-shadow: 0 0 0 2px white, 0 0 0 3px #27AE60;
	}
	/*headings*/
	.title {
		font-size: 15px;
		text-transform: uppercase;
		color: #2C3E50;
		margin-bottom: 10px;
	}

	.subtitle {
		font-weight: normal;
		font-size: 13px;
		color: #666;
		margin: -15px 0 10px;
		line-height: 20px;
	}

	/*error message*/
	.errorMessage {
		font-weight: normal;
		font-size: 13px;
		color: #B51E1E;
		margin: -15px 0 10px;
	}

	.register-form {
	width: 400px;
	margin: 50px auto;
	text-align: center;
	position: relative;
	}

	#progressbar {
	margin-bottom: 30px;
	margin-left: 20%;
	overflow: hidden;
	/*CSS counters to number the steps*/
	counter-reset: step;
	}

	#progressbar li {
		list-style-type: none;
		color: black;
		text-transform: uppercase;
		font-size: 9px;
		width: 33.33%;
		float: left;
		position: relative;
	}
	#progressbar li:before {
		content: counter(step);
		counter-increment: step;
		width: 20px;
		line-height: 20px;
		display: block;
		font-size: 10px;
		color: #333;
		background: #DAD6D6;
		border-radius: 3px;
		margin: 0 auto 5px auto;
	}
	/*progressbar connectors*/
	#progressbar li:after {
		content: '';
		width: 100%;
		height: 2px;
		background: black;
		position: absolute;
		left: -50%;
		top: 9px;
		z-index: -1; /*put it behind the numbers*/
	}
	#progressbar li:first-child:after {
		/*connector not needed before the first step*/
		content: none; 
	}
	/*marking active/completed steps green*/
	/*The number of the step and the connector before it = green*/
	#progressbar li.active:before,  #progressbar li.active:after{
		background: #27AE60;
		color: white;
	}


	</style>

</register>