/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function popUp() {
    $('#nuevo_usuario').click(function () {
        $('#pop').fadeIn('slow');
        $("#capa").fadeIn('slow');
        $('#capa').height($(window).height());
        return false;
    });

    $('#close').click(function () {
        $('#pop').fadeOut('slow');
        $('#capa').fadeOut('slow');
        return false;
    });


}

function nuevoUsuario() {
    var nombre = $("#nuevo_nombre").val();
    var contrasena = $("#nueva_contrasena").val();
    var nueva_contrasena = $("#x_contrasena").val();
    var privilegio = 0;
    if ($("#tendero").is(':checked')) {
        privilegio = 0;
    }
    else if ($("#admin").is(':checked')) {
        privilegio = 1;
    }
    var strPost = "nombre=" + nombre + "&contrasena=" + contrasena + "&privilegio=" + privilegio;
    if (contrasena == nueva_contrasena) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: strPost,
            dataType: "json",
            url: "Sesion_usuario.jsp?ID=nuevo_usuario",
            success: function (info) {
                if (info.estado == "creado") {
                    setTimeout(function () {
                        window.location.href = "index.jsp";
                    }, 500);

                }
                else if(info.estado == "no_creado"){
                    alert("El usuario no pudo crearse")
                }
                else if(info.estado=="existente"){
                    alert("Nombre de usuario en uso, prueba con otro");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });
    }
}

function iniciarSesion() {
    var nombre = $("#nombre").val();
    var contrasena = $("#contrasena").val();
    var strPost = "nombre=" + nombre + "&contrasena=" + contrasena;
    $.ajax({scriptCharset: "utf-8",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        cache: false,
        type: "POST",
        data: strPost,
        dataType: "json",
        url: "Sesion_usuario.jsp?ID=inicio_sesion",
        success: function (info) {
            if (info.inicio == "ok") {

                setTimeout(function () {
                    window.location.href = "index.jsp";
                }, 500);
            }
            else if (info.inicio == "no") {
                $("#contrasena").after("<p>El usuario o password es incorrecto</p>");
            }
        },
        error: function (error) {
            alert("ocurrio un error" + error);
        }
    });
}

function nuevoUsuario_admin(){
    var nombre = $("#nuevo_nombre").val();
    var contrasena = $("#nueva_contrasena").val();
    var nueva_contrasena = $("#x_contrasena").val();
    var privilegio = 0;
    if ($("#tendero").is(':checked')) {
        privilegio = 0;
    }
    else if ($("#admin").is(':checked')) {
        privilegio = 1;
    }
    var strPost = "nombre=" + nombre + "&contrasena=" + contrasena + "&privilegio=" + privilegio;
    if (contrasena == nueva_contrasena) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: strPost,
            dataType: "json",
            url: "Sesion_usuario.jsp?ID=nuevo_usuario",
            success: function (info) {
                if (info.estado == "creado") {
                    alert("Usuario creado");
                    $('#pop').fadeOut('slow');
                    $('#capa').fadeOut('slow');
                }
                else if(info.estado == "no_creado"){
                    alert("Usuario no se pudo crear");
                }else if(info.estado == "existente"){
                    alert("Nombre de usuario en uso, prueba con otro");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });
    }
}

function log_out(){
    $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            dataType: "json",
            url: "Sesion_usuario.jsp?ID=logout",
            success: function (info) {
                if (info.sesion == "out") {
                    setTimeout(function(){
                      window.location.href="Bambu_Login.jsp";  
                    },300);
                    
                }
                else{
                    alert("No se puedo terminar con la sesion");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });
}
$(document).ready(function () {
    popUp();
    $("#crear_usuario").click(function () {
        nuevoUsuario();
    });
    $("#nuevoUsuario").click(function(){
        $('#pop').fadeIn('slow');
        $("#capa").fadeIn('slow');
        $('#capa').height($(window).height());
    });
    $("#iniciar_sesion").click(function () {
        iniciarSesion();
    });
    $("#logout").click(function(){
        log_out();
    });
});