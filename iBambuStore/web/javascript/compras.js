var subtotal_compra = 0;
var total_compra = 0;
var iva_compra = 0;
var id_row;
var contador = 0;
function productoDetalle() {
    var codigo = $("#prod_compra").val();
    var cantidad_compra = $("#cantidad_compra").val();
    var subtotal_compra_detalle = 0;
    var total_compra_detalle = 0;
    var iva_compra_detalle = 0;
    if (cantidad_compra > 0) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: "codigo_producto=" + codigo + "&cantidad=" + cantidad_compra,
            dataType: "json",
            url: "Main.jsp?ID=compra_detalle",
            success: function(info) {
                if (info.nombre != undefined) {
                    if (info.hasCode == "0") {
                        total_compra_detalle = parseFloat(info.precio_compra * cantidad_compra).toFixed(2);
                        subtotal_compra_detalle = parseFloat(total_compra_detalle);
                        iva_compra_detalle = 0;
                    }
                    else if (info.hasCode == "1") {
                        total_compra_detalle = parseFloat(info.precio_compra * cantidad_compra).toFixed(2);
                        subtotal_compra_detalle = total_compra_detalle / 1.16;
                        iva_compra_detalle = subtotal_compra_detalle * 0.16;
                    }

                    var contenido = "";
                    id_row = "compra" + contador;
                    contenido += "<tr id='" + id_row + "'> <td>" + info.nombre + " " + info.medida + "</td>";
                    contenido += "<td>" + cantidad_compra + "</td>";
                    contenido += "<td>" + subtotal_compra_detalle.toFixed(2) + "</td>";
                    contenido += "<td>" + iva_compra_detalle.toFixed(2) + "</td>";
                    contenido += "<td>" + total_compra_detalle + "</td>";
                    contenido += "<td> <img style='cursor:pointer' src='imagen/round.png' )></td>";
                    $("#compra_detalles tr:last").after(contenido);
                    total_compra += parseFloat(total_compra_detalle);
                    subtotal_compra += subtotal_compra_detalle;
                    iva_compra += iva_compra_detalle;
                    $("#subtotal_compra").val(subtotal_compra.toFixed(2));
                    $("#ivatotal_compra").val(iva_compra.toFixed(2));
                    $("#total_compra").val(total_compra.toFixed(2));
                    $("#compra_detalles tr:last img").data("datos", info);
                    $("#compra_detalles tr:last img").data("id_row", "#" + id_row);
                    $("#compra_detalles tr:last img").data("cantidad", cantidad_compra);
                    $("#compra_detalles tr:last img").data("costo", total_compra_detalle);
                    $("#compra_detalles tr:last img").data("iva", iva_compra_detalle);
                    $("#compra_detalles tr:last img").data("subtotal", subtotal_compra_detalle);
                    total_compra_detalle = 0;
                    subtotal_compra_detalle = 0;
                    iva_compra_detalle = 0;
                    $("#prod_compra").val("");
                    $("#cantidad_compra").val("0");
                    contador++;

                } else {
                    alert("No existe el producto");
                }
            },
            error: function(error) {
                alert("ocurrio un error" + error);
            }
        });
    }
    else {
        alert("Coloque la cantidad ( + de 0)");
    }
}

function remover_detalleCompra() {
    $("#compra_detalles").on("click", "img", function() {
        var imagen = $(this);
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: "codigo=" + imagen.data("datos").codigo_producto + "&cantidad=" + imagen.data("cantidad"),
            dataType: "json",
            url: "Main.jsp?ID=remover_prod_compra",
            success: function(info) {
                if (info.estado == "ok") {
                    total_compra -= parseFloat(imagen.data("costo"));
                    iva_compra -= parseFloat(imagen.data("iva"));
                    subtotal_compra -= parseFloat(imagen.data("subtotal"));
                    $("#ivatotal_compra").val(parseFloat(iva_compra).toFixed(2));
                    $("#subtotal_compra").val(parseFloat(subtotal_compra).toFixed(2));
                    $("#total_compra").val(parseFloat(total_compra).toFixed(2));
                    $(imagen.data("id_row")).remove();
                } else {
                    alert("No pudo eliminarse le producto");
                }
            },
            error: function(error) {
                alert("ocurrio un error" + error);
            }
        });

    });
}

function busquedaProveedor() {
    var proveedor = $("#search_proveedor").val();
    $.ajax({scriptCharset: "utf-8",
        contentType: "application/x-www-form-urlencoded;charset=utf-8",
        cache: false,
        type: "POST",
        data: "proveedor=" + proveedor,
        dataType: "json",
        url: "Main.jsp?ID=obtener_proveedor",
        success: function(info) {
            var opciones = "";
            for (var i = 0; i < info.length; i++) {
                opciones += "<option value='" + info[i].id_proveedor + "'>";
                opciones += info[i].empresa + "</option>";
            }

            $("#list_proveedores").html(opciones);
        },
        error: function(error) {
            alert("ocurrio un error" + error);
        }
    });
}

function hacerCompra() {

    var cabeceros = "<tr> <th>Producto</th>";
    cabeceros += "<th>Cantidad</th><th>Subtotal</th><th>Iva</th><th>Total</th><th>&nbsp; - &nbsp;</th></tr>";
    var total_hcompra = parseFloat($("#total_compra").val());
    var iva_hcompra = parseFloat($("#ivatotal_compra").val());
    var subtotal_hcompra = parseFloat($("#subtotal_compra").val());
    var credito_hcompra;
    if ($("#is_credio").is(':checked')) {
        credito_hcompra = 1;
    } else {
        credito_hcompra = 0;
    }
    var proveedor_hcompra = $("#list_proveedores").val();
    var strPost = "total_venta=" + total_hcompra + "&iva_total=" + iva_hcompra;
    strPost += "&subtotal=" + subtotal_hcompra + "&credito=" + credito_hcompra;
    strPost += "&proveedor=" + proveedor_hcompra;
    if (confirm("Se realizará la compra, esta seguro?")) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            type: "POST",
            data: strPost,
            dataType: "json",
            url: "Main.jsp?ID=hacer_compra",
            success: function(info) {
                if (info.compra == "ok") {
                    $("#compra_detalles tr").remove();
                    $("#compra_detalles").html(cabeceros);
                    $("#total_compra").val(0.0);
                    $("#ivatotal_compra").val(0.0);
                    $("#subtotal_compra").val(0.0);
                    total_compra = 0;
                }
                else if (info.compra == "noventa") {
                    alert("La compra no pudo ser procesada");
                }
                else if (info.compra == "nodetalle") {
                    alert("La lista de productos no pudo ser procesada");
                }
            },
            error: function(error) {
                alert("ocurrio un error" + error);
            }
        });
    } else {
        cancelarCompra();
    }
}

function cancelarCompra() {
    var cabeceros = "<tr> <th>Producto</th>";
    cabeceros += "<th>Cantidad</th><th>Subtotal</th><th>Iva</th><th>Total</th><th>&nbsp; - &nbsp;</th></tr>";
    if (confirm("¿Esta seguro que desea cancelar la venta?")) {
        $.ajax({scriptCharset: "utf-8",
            contentType: "application/x-www-form-urlencoded;charset=utf-8",
            cache: false,
            dataType: "json",
            url: "Main.jsp?ID=cancelar_compra",
            success: function(info) {
                if (info.estado == "ok") {
                    $("#compra_detalles tr").remove();
                    $("#compra_detalles").html(cabeceros);
                    $("#total_compra").val(0.0);
                    $("#ivatotal_compra").val(0.0);
                    $("#subtotal_compra").val(0.0);
                    total_compra = 0;
                }
                else {
                    alert("Error al cancelar la compra");
                }
            },
            error: function(error) {
                alert("ocurrio un error" + error);
            }
        });
    }
}

$(document).ready(function() {
    remover_detalleCompra();
    $("#addProducto").click(function() {
        productoDetalle();
    });

    $("#search_proveedor").keydown(function(e) {
        if (e.keyCode == 13) {
            busquedaProveedor();
        }
    });

    $("#hacer_compra").click(function() {
        hacerCompra();
    });

    $("#cancelar_compra").click(function() {
        cancelarCompra();
    });
});
