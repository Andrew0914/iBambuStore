var conta = 0;
var id_prod;
var total_venta = 0;
var objeto_temp;

function getProducto() {
    var codigo = $("#codigo_producto").val();
    $.ajax({scriptCharset: "utf-8",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        cache: false,
        type: "POST",
        data: "codigo_producto=" + codigo,
        dataType: "json",
        url: "Main.jsp?ID=obtener_producto",
        success: function (info) {
            if (info.codigo_producto != undefined) {
                id_prod = "prod" + conta;
                var contenido = "<tr id='" + id_prod + "'>";
                contenido += "<td>" + info.codigo_producto + "</td>";
                contenido += "<td>" + info.nombre + "</td>";
                contenido += "<td>" + info.unidad + "</td>";
                contenido += "<td>" + info.medida + "</td>";
                contenido += "<td>" + info.precio_venta + "</td>";
                contenido += "<td> <img style='cursor:pointer' src='imagen/eliminar.png' title='eliminar' class='eliminar'></td>";
                contenido += "</tr>";
                if (info.hasCode == "0") {
                    $('#pop_producto_und').fadeIn('slow');
                    $("#capa").fadeIn('slow');
                    $('#capa').height($(window).height());
                    objeto_temp = info;
                    $("#productos_venta tr:last").after(contenido);

                }
                else if (info.hasCode == "1") {
                    total_venta += parseFloat(info.precio_venta);
                    $("#total_venta").val(parseFloat(total_venta).toFixed(2));
                    $("#productos_venta tr:last").after(contenido);
                    $("#productos_venta tr:last img").data("datos", info);
                    $("#productos_venta tr:last img").data("id_row", "#" + id_prod);
                    $("#productos_venta tr:last img").data("cantidad", 1);
                    $("#productos_venta tr:last img").data("costo", info.precio);
                }

                $("#codigo_producto").val("");
                contenido = "";
                conta++;
            } else {
                alert("El producto no existe");
            }
        },
        error: function (error) {
            alert("No existe le producto " + error);
        }
    });
}


function costo_gramaje() {
    var gramaje_litraje = 0;
    var precio_real = 0;
    var kilogramaje = 0;
    $("#btn_unidades").click(function () {
        $("#productos_venta tr:last img").data("datos", objeto_temp);
        $("#productos_venta tr:last img").data("id_row", "#" + id_prod);
        gramaje_litraje = $("#unidades_compradas").val();
        if ($("#kilos").is(':checked')) {

            precio_real = parseFloat(objeto_temp.precio) * parseFloat(gramaje_litraje);
            kilogramaje = parseFloat(gramaje_litraje).toFixed(2);
        }
        else if ($("#gramos").is(':checked')) {

            precio_real = parseFloat(objeto_temp.precio) * (parseFloat(gramaje_litraje) / 1000);
            kilogramaje = (parseFloat(gramaje_litraje) / 1000).toFixed(2);
        }
        else if ($("#pesos").is(':checked')) {

            precio_real = parseFloat(gramaje_litraje);
            kilogramaje = parseFloat(precio_real / objeto_temp.precio);
        }
        $("#productos_venta tr:last img").data("cantidad", kilogramaje);
        $("#productos_venta tr:last img").data("costo", precio_real);

        var strPost = "codigo_producto=" + objeto_temp.codigo_producto + "&cantidad_gramaje=" + kilogramaje;
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: strPost,
            dataType: "json",
            url: "Main.jsp?ID=cantidad_especial",
            success: function (info) {
                if (info.estado == "ok") {
                    $("#productos_venta tr:last td")[2].innerHTML = "" + kilogramaje + "";
                    total_venta += precio_real;
                    $("#total_venta").val(parseFloat(total_venta).toFixed(2));
                    $('#pop_producto_und').fadeOut('slow');
                    $("#capa").fadeOut('slow');
                    $("#unidades_compradas").val(0);

                } else {
                    alert("Ocurrio un error en las cargas de la lista de productos");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });

    });


}

function remover_detalleVenta() {
    $("#productos_venta").on("click", "img", function () {
        var imagen = $(this);
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: "codigo=" + imagen.data("datos").codigo_producto + "&cantidad=" + imagen.data("cantidad") + "&hascodigo=" + imagen.data("datos").hasCode,
            dataType: "json",
            url: "Main.jsp?ID=remover_producto_venta",
            success: function (info) {
                if (info.estado == "ok") {
                    total_venta -= parseFloat(imagen.data("costo"));
                    $("#total_venta").val(parseFloat(total_venta).toFixed(2));
                    $(imagen.data("id_row")).remove();
                } else {
                    alert("No pudo eliminarse le producto");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });

    });
}
function hacerVenta() {
    var cabeceros = "<tr> <th>C&oacute;digo</th>";
    cabeceros += "<th>Nombre</th><th>Medida</th><th>Unidad</th><th>Precio</th><th>&nbsp; - &nbsp;</th></tr>";
    var total_hventa = parseFloat($("#total_venta").val());
    var pago_venta = parseFloat($("#pago_venta").val());
    var cambio_venta = 0;
    if (total_hventa > 0) {
        if (pago_venta >= total_hventa) {
            cambio_venta = pago_venta - total_hventa;
            $("#cambio_venta").val(cambio_venta.toFixed(2));
            if (confirm("Se realizará la venta, esta seguro?")) {
                $.ajax({scriptCharset: "utf-8",
                    contentType: "application/x-www-form-urlencoded;charset=utf-8",
                    cache: false,
                    type: "POST",
                    data: "total_venta=" + total_hventa,
                    dataType: "json",
                    url: "Main.jsp?ID=hacer_venta",
                    success: function (info) {
                        if (info.venta == "ok") {
                            $("#productos_venta tr").remove();
                            $("#productos_venta").html(cabeceros);
                            $("#total_venta").val(0);
                            $("#pago_venta").val(0);
                            $("#cambio_venta").val(0);
                            total_venta = 0;
                            imprimirTicket();
                        }
                        else if (info.venta == "noventa") {
                            alert("La venta no pudo ser procesada");
                        }
                        else if (info.venta == "nodetalle") {
                            alert("La lista de productos no pudo ser procesada");
                        }
                    },
                    error: function (error) {
                        alert("ocurrio un error" + error);
                    }
                });
            } else {
                cancelarVenta();
            }
        } else {
            alert("El pago es insuficiente");
            cambio_venta = 0;
            $("#cambio_venta").val(cambio_venta);
        }
    } else {
        alert("El total esta en 0 no hay venta para realizar");
    }
}

function cancelarVenta() {
    var cabeceros = "<tr> <th>C&oacute;digo</th>";
    cabeceros += "<th>Nombre</th><th>Medida</th><th>Unidad</th><th>Precio</th><th>&nbsp; - &nbsp;</th></tr>";
    if (confirm("¿Esta seguro que desea cancelar la venta?")) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            dataType: "json",
            url: "Main.jsp?ID=cancelar_venta",
            success: function (info) {
                if (info.estado == "ok") {
                    $("#productos_venta tr").remove();
                    $("#productos_venta").html(cabeceros);
                    $("#total_venta").val(0);
                    $("#pago_venta").val(0);
                    $("#cambio_venta").val(0);
                    total_venta = 0;
                }
                else {
                    alert("Error al cancelar la venta");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });
    }
}

function findProducto() {
    var todos;
    var producto;
    if ($("#nombre_codigo_prod").val() == "") {
        producto = "no_codigo";
    } else {
        producto = $("#nombre_codigo_prod").val();
    }
    var precio1 = parseFloat($("#precio1").val());
    var precio2 = parseFloat($("#precio2").val());
    var ordenamiento_prod = $("#ordenamiento_prod").val();
    var strPost = "";
    if ($("#todos").is(':checked')) {
        todos = 1;

    } else {
        todos = 0;
    }
    if (isNaN(precio1) & isNaN(precio2)) {
        precio1 = 0;
        precio2 = 0;
    }
    if (precio1 > precio2) {
        alert(" Precio 1 debe ser menor o igual que Precio2 \n para establecer un rango ");
    } else {
        strPost += "todos=" + todos + "&producto=" + producto;
        strPost += "&precio1=" + precio1 + "&precio2=" + precio2;
        strPost += "&ordenamiento=" + ordenamiento_prod;
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: strPost,
            dataType: "json",
            url: "Main.jsp?ID=busquedaProducto",
            success: function (info) {
                var contenido = "<tr><th>Codigo</th><th>Nombre</th><th>Medida</th><th>Unidad</th><th>Precio venta</th><th>Precio compra </th><th>-</th><th>-</th></tr>";
                for (var i = 0; i < info.length; i++) {
                    contenido += "<tr> <td>" + info[i].codigo_producto + "</td>";
                    contenido += "<td><input class='uneditProd' type='text' value='" + info[i].nombre + "' readonly></td>";
                    contenido += "<td><input class='uneditProd' type='text' value='" + info[i].medida + "' readonly></td>";
                    contenido += "<td><input class='uneditProd' type='text' value='" + info[i].unidad + "' readonly></td>";
                    contenido += "<td><input class='uneditProd' type='text' value='" + info[i].precio_venta + "' readonly></td>";
                    contenido += "<td><input class='uneditProd' type='text' value='" + info[i].precio_compra + "' readonly></td>";
                    contenido += "<td> <img class='ajustarProd' src='imagen/spanner3.png'></td>";
                    contenido += "<td> <img class='eliminarProd' src='imagen/eliminar.png'> </td></tr> ";
                }
                $("#resultado_productos").html(contenido);
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });

    }

}
function modificarProducto() {
    $("#resultado_productos").on("click", ".ajustarProd", function () {
        $("#resultado_productos input").attr("readonly", "true");
        $("#resultado_productos input").removeClass("editables");
        var current_fila = ($(this).parent().parent()).children("td").children("input");
        current_fila.addClass("editables");
        current_fila.removeAttr("readonly");
        $(this).parent().parent().data("isModify", true);
    });
}
function guardarCambiosProducto() {
    var datarow = "";
    var fila = $("#resultado_productos tr");
    fila.each(function (index, row) {
        if ($(row).data("isModify")) {
            datarow += $(row).first("td").text().trim() + ",";
            $(row).children("td").children("input").each(function (i, caja) {
                datarow += $(caja).val() + ",";
            });
            datarow += ";";
        }
    });
    if (datarow != "") {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: "datos=" + datarow,
            dataType: "json",
            url: "Main.jsp?ID=",
            success: function (info) {
                if (info.update == "ok") {
                    cancelarCambioProducto();
                } else if (info.update == "no") {
                    alert("No se pudieron guardar lso cambios");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });

    }
    else {
        alert("No se a realizado ningun cambio");

    }
}
function cancelarCambioProducto() {
    $("#resultado_productos input").attr("readonly", "true");
    $("#resultado_productos input").removeClass("editables");
    var fila_cancelada = $("#resultado_productos tr");
    fila_cancelada.each(function (index, row) {
        if ($(row).data("isModify")) {
            $(row).removeData("isModify");
        }
    });

}

function borrarUnproducto() {
    $("#resultado_productos").on("click", ".eliminarProd", function () {
        var current = $(this);
        var producto_eliminado = $(this).parent().parent().first("td").text().trim();
        if (confirm("Al eliminar este producto se eliminara \n por completo de tu lista real y de \n esta tabla, estas seguro?")) {
            $.ajax({scriptCharset: "utf-8",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                cache: false,
                type: "POST",
                data: "producto=" + producto_eliminado,
                dataType: "json",
                url: "Main.jsp?ID=delete_producto",
                success: function (info) {
                    if (info.update == "ok") {
                        current.parent().parent().remove();
                    } else if (info.update == "no") {
                        alert("No se pudo eliminar el producto");
                    }
                },
                error: function (error) {
                    alert("ocurrio un error" + error);
                }
            });
        }
    });
}

function findrProveedror() {
    var proveedor = $("#busq_proveedor").val();
    $.ajax({scriptCharset: "utf-8",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        cache: false,
        type: "POST",
        data: "proveedor=" + proveedor,
        dataType: "json",
        url: "Main.jsp?ID=obtener_proveedor",
        success: function (info) {
            var content = "<tr><th>ID</th><th>Empresa </th><th>Telefono</th><th>Nombre</th><th>Apellido P</th><th>Apellido M</th><th>-</th><th>-</th></tr>";
            for (var i = 0; i < info.length; i++) {
                content += "<tr><td>" + info[i].id_proveedor + "</td>";
                content += "<td><input class='uneditProd' type='text' value='" + info[i].empresa + "' readonly></td>";
                content += "<td><input class='uneditProd' type='text' value='" + info[i].telefono + "' readonly></td>";
                content += "<td><input class='uneditProd' type='text' value='" + info[i].nombre_distribuidor + "' readonly></td>";
                content += "<td><input class='uneditProd' type='text' value='" + info[i].apaterno_distribuidor + "' readonly></td>";
                content += "<td><input class='uneditProd' type='text' value='" + info[i].amaterno_distribuidor + "' readonly></td>";
                content += "<td><img class='ajustarProveedor' src='imagen/spanner3.png'></td>";
                content += "<td><img class='eliminarProveedor' src='imagen/eliminar.png'></td></tr>";
            }
            $("#resutlados_proveedores").html(content);
        },
        error: function (error) {
            alert("ocurrio un error" + error);
        }
    });
}

function ajustaProoveedor() {
    $("#resutlados_proveedores").on("click", ".ajustarProveedor", function () {
        $("#resutlados_proveedores input").attr("readonly", "true");
        $("#resutlados_proveedores input").removeClass("editables");
        var current_fila = ($(this).parent().parent()).children("td").children("input");
        current_fila.addClass("editables");
        current_fila.removeAttr("readonly");
        $(this).parent().parent().data("isModify", true);
    });
}

function guardarCambiosProveedor() {
    var datarow = "";
    var fila = $("#resutlados_proveedores tr");
    fila.each(function (index, row) {
        if ($(row).data("isModify")) {
            datarow += $(row).first("td").text().trim() + ",";
            $(row).children("td").children("input").each(function (i, caja) {
                datarow += $(caja).val() + ",";
            });
            datarow += ";";
        }
    });
    if (datarow != "") {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: "datos=" + datarow,
            dataType: "json",
            url: "Main.jsp?ID=update_proveedor",
            success: function (info) {
                if (info.update == "ok") {
                    cancelarCambioProveedor();
                } else if (info.update == "no") {
                    alert("No se pudieron guardar los cambios");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });

    }
    else {
        alert("No se a realizado ningun cambio");

    }
}

function cancelarCambioProveedor() {
    $("#resutlados_proveedores input").attr("readonly", "true");
    $("#resutlados_proveedores input").removeClass("editables");
    var fila_cancelada = $("#resutlados_proveedores tr");
    fila_cancelada.each(function (index, row) {
        if ($(row).data("isModify")) {
            $(row).removeData("isModify");
        }
    });
}

function borrarUnProveedor() {
    $("#resutlados_proveedores").on("click", ".eliminarProveedor", function () {
        var current = $(this);
        var proveedor_eliminado = $(this).parent().parent().first("td").text().trim();
        if (confirm("Al eliminar este proveedor se eliminara \n por completo de tu lista real y de \n esta tabla, estas seguro?")) {
            $.ajax({scriptCharset: "utf-8",
                contentType: "application/x-www-form-urlencoded;charset=utf-8",
                cache: false,
                type: "POST",
                data: "proveedor=" + proveedor_eliminado,
                dataType: "json",
                url: "Main.jsp?ID=delete_proveedor",
                success: function (info) {
                    if (info.update == "ok") {
                        current.parent().parent().remove();
                    } else if (info.update == "no") {
                        alert("No se pudo eliminar el producto");
                    }
                },
                error: function (error) {
                    alert("ocurrio un error" + error);
                }
            });
        }
    });
}

function agregarProveedor() {
    var dato1 = $("#nombre_empresa").val();
    var dato2 = $("#telefonoprov").val();
    var dato3 = $("#distribuidorprov").val();
    var dato4 = $("#paternoprov").val();
    var dato5 = $("#maternoprov").val();
    var strPost = "empresa=" + dato1 + "&telefono=" + dato2 + "&distribuidor=" + dato3 + "&paterno=" + dato4 + "&materno="+dato5;
    if (dato2.length <= 10) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: strPost,
            dataType: "json",
            url: "Main.jsp?ID=insert_proveedor",
            success: function (info) {
                if (info.update == "ok") {
                    $('#popNuevoProveedor').fadeOut('slow');
                    $("#capa").fadeOut('slow');
                } else if (info.update == "no") {
                    alert("No sep udo agregar proveedor");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });
    } else {
        alert("El telefono debe ser de 10 digitos");
    }
}
function agregarProducto() {
    var dato0 = $("#codigoprod").val();
    var dato1 = $("#nombre_producto").val();
    var dato2 = $("#medidaprod").val();
    var dato3 = $("#unidadprod").val();
    var dato4 = $("#precioventa").val();
    var dato5 = $("#preciocompra").val();
    var barras =0;
    if($("#barras").is(":checked")){
         barras = 1;
    }else{
         barras = 0;
    }
    var strPost = "codigo=" + dato0 + "&nombre=" + dato1 + "&unidad=" + dato2 + "&medida=" + dato3 + "&precioventa=" + dato4 + "&barras="+barras + "&preciocompra="+dato5;
    if (dato0.length <= 15) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: strPost,
            dataType: "json",
            url: "Main.jsp?ID=insert_producto",
            success: function (info) {
                if (info.update == "ok") {
                    $('#popNuevoProducto').fadeOut('slow');
                    $("#capa").fadeOut('slow');
                } else if (info.update == "no") {
                    alert("No sep udo agregar producto");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });
    } else {
        aler("Codigo demaciado largo ");
    }
}

function imprimirTicket() {
    if (confirm("Desea obtener el ticket de venta")) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            dataType: "json",
            url: "Main.jsp?ID=imprimir_ticket",
            success: function (info) {
                if (!info.imprimir == "ok") {
                    alert("No pudo imprimirse el ticket");
                }
            },
            error: function (error) {
                alert("ocurrio un error" + error);
            }
        });
    }
}

function generarReporteVenta(strPost) {
    $.ajax({scriptCharset: "utf-8",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        cache: false,
        data: strPost,
        type: "post",
        dataType: "json",
        url: "Main.jsp?ID=reporte_venta",
        success: function (info) {
            var total_rep = 0;
            var iva_rep = 0 ;
            var subtotal_rep = 0;
            var contenido = "<tr>";
            contenido += "<th> # Venta </th> <th>Fecha</th> <th>Importe</th> <th>Iva</th> <th>Total</th> </tr>";
            for (var i = 0; i < info.length; i++) {
                total_rep += parseFloat(info[i].total);
                subtotal_rep += parseFloat(info[i].importe);
                iva_rep += parseFloat(info[i].iva_venta);
                contenido += "<tr> <td>" + info[i].idVenta + "</td>";
                contenido += "<td>" + info[i].fecha_venta + "</td>";
                contenido += "<td>$ " + info[i].importe + "</td>";
                contenido += "<td>$ " + info[i].iva_venta + "</td>";
                contenido += "<td>$ " + info[i].total + "</td></tr>"
            }
            contenido += "<tr><td class='totales_borde'></td><td class='totales_borde'>Totales:</td>";
            contenido += "<td class='totales_borde'>"+subtotal_rep.toFixed(2)+"</td>";
            contenido += "<td class='totales_borde'>"+iva_rep.toFixed(2) + "</td>";
            contenido += "<td class='totales_borde'>"+total_rep.toFixed(2) + "</td></tr>";
            $("#reportes_table").html(contenido);
        },
        error: function (error) {
            alert("ocurrio un error" + error);
        }
    });
}
function generarReporteCompra(strPost) {
    $.ajax({scriptCharset: "utf-8",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        cache: false,
        data: strPost,
        type: "post",
        dataType: "json",
        url: "Main.jsp?ID=reporte_compra",
        success: function (info) {
            var total_rep = 0;
            var iva_rep = 0 ;
            var subtotal_rep = 0;
            var contenido = "<tr>";
            contenido += "<th> # Compra </th> <th>Fecha</th><th>Credito</th> <th>Importe</th> <th>Iva</th> <th>Total</th> </tr>";
            for (var i = 0; i < info.length; i++) {
                total_rep += parseFloat(info[i].total);
                subtotal_rep += parseFloat(info[i].importe);
                iva_rep += parseFloat(info[i].iva_compra);
                contenido += "<tr> <td>" + info[i].id_compra + "</td>";
                contenido += "<td>" + info[i].fecha_compra + "</td>";
                if (info[i].credito == "1") {
                    contenido += "<td>Credito</td>";
                } else if (info[i].credito == "0") {
                    contenido += "<td>Pagada</td>";
                }
                contenido += "<td>$ " + info[i].importe + "</td>";
                contenido += "<td>$ " + info[i].iva_compra + "</td>";
                contenido += "<td>$ " + info[i].total + "</td></tr>";
            }
            contenido += "<tr><td class='totales_borde'></td><td class='totales_borde'></td><td class='totales_borde'>Totales:</td>";
            contenido += "<td class='totales_borde'>"+subtotal_rep.toFixed(2)+"</td>";
            contenido += "<td class='totales_borde'>"+iva_rep.toFixed(2) + "</td>";
            contenido += "<td class='totales_borde'>"+total_rep.toFixed(2) + "</td></tr>";
            $("#reportes_table").html(contenido);
        },
        error: function (error) {
            alert("ocurrio un error" + error);
        }
    });
}

function doReportes(){
    var fecha1 = $("#fecha1").val();
    var fecha2 = $("#fecha2").val();
    var post = "fecha1="+fecha1 + "&fecha2="+fecha2;
    if($("#reporte_venta").is(":checked")){
        generarReporteVenta(post);
    }
    if($("#reporte_compra").is(":checked")){
        generarReporteCompra(post);
    }
}

function soloNumeros(){
    $(".soloNumeros").keydown(function (e){
        if(!(e.keyCode >= 48 & e.keyCode <= 57 | e.keyCode == 190 | e.keyCode ==8)){
            e.preventDefault();
        }
    });
}
$(document).ready(function () {
    soloNumeros();
    $("#obtener_reporte").click(function(){
        doReportes();
    });
    $("#addProductox").click(function () {
        agregarProducto();
    });
    $("#agregarProducto").click(function () {
        $('#popNuevoProducto').fadeIn('slow');
        $("#capa").fadeIn('slow');
        $('#capa').height($(window).height());
    });
    $("#cancelarAddProd").click(function () {
        $('#popNuevoProducto').fadeOut('slow');
        $("#capa").fadeOut('slow');
    });

    $("#addProveedor").click(function () {
        agregarProveedor();
    });
    $("#cancelarAddProv").click(function () {
        $('#popNuevoProveedor').fadeOut('slow');
        $("#capa").fadeOut('slow');
    });
    $("#agregarProveedor").click(function () {
        $('#popNuevoProveedor').fadeIn('slow');
        $("#capa").fadeIn('slow');
        $('#capa').height($(window).height());
    });
    borrarUnProveedor();
    $("#cancelarProveedores").click(function () {
        cancelarCambioProveedor();
    });
    $("#guardarProveedores").click(function () {
        guardarCambiosProveedor();
    });
    ajustaProoveedor();
    $("#buscarProveedores").click(function () {
        findrProveedror();
    });
    borrarUnproducto();
    $("#guardarCambiosProducto").click(function () {
        guardarCambiosProducto();
    });
    $("#cancelarCambiosProducto").click(function () {
        cancelarCambioProducto();
    });
    modificarProducto();
    costo_gramaje();
    remover_detalleVenta();
    $("#buscar_prod").click(function () {
        findProducto();
    });
    $("#codigo_producto").keydown(function (e) {
        if (e.keyCode == 13) {
            getProducto();
        }
    });

    $("#hacer_venta").click(function () {
        hacerVenta();
    });

    $("#cancelar_venta").click(function () {
        cancelarVenta();
    });

    $('.hastip').tooltipsy({
        offset: [10, 0],
        css: {
            'padding': '5px',
            'max-width': '200px',
            'color': '#FFF',
            'background-color': 'green',
            'border': '1px solid #deca7e',
            '-moz-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
            '-webkit-box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
            'box-shadow': '0 0 10px rgba(0, 0, 0, .5)',
            'text-shadow': 'none'
        }
    });

});

