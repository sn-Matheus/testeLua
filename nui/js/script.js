var app = new Vue({
    el: '#app',
    data:{
       ver: false ,
       message: "Insira seu email"
    }
 })
 


 document.addEventListener("DOMContentLoaded", function() {
 window.addEventListener("message",(event)=>{

    let data = event.data
 
    if (data.action == true){
       app.ver = true
    }else{
       app.ver = false
    }
 })
})
 

 function sair(){
    app.ver = false
    fetch("http://sn-Matheus/fechar", { method: "POST" })
 }

 