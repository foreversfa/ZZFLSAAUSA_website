


//-------------------------------------------//


// riot.route('/logsign',function(){
    
//     riot.mount('#Login','logsign')
// })

riot.route('/register',function(){
    riot.mount('#Mount','register')
})

riot.route(function(){
    riot.mount('#Mount','homepage');
})


riot.route.start(true)


