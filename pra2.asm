.model small
.radix 16
.stack
.data
usac    db   "Universidad de San Carlos de Guatemala","$"
curso   db   "Arquitectura de Computadoras y Ensambladores 1","$"
seccion db   "Seccion N","$"
periodo db   "Escuela de vacaciones de Junio 2023","$"
nombre  db   "CARLOS JAVIER MARTINEZ POLANCO 201709282","$"
nl        db 0a,"$"
linea_div db "=================================================", "$"
;;MENU PRINCIPAL
titulo_menu db "            MENU DEL SISTEMA", "$"
;;PRODUCTOS
titulo_productos db "(1) OPCIONES DE PRODUCTOS", "$"
subtitulo_productos1 db "(1) INGRESAR PRODUCTOS", "$"
ingresar_prod db "HAS SELECCIONADO INGRESAR PRODUCTO", "$"
subtitulo_productos2 db "(2) ELIMINAR PRODUCTOS", "$"
eliminar_prod db "HAS SELECCIONADO ELIMINAR PRODUCTO", "$"
subtitulo_productos3 db "(3) VER PRODUCTOS", "$"
ver_prod db "HAS SELECCIONADO VER PRODUCTOS", "$"
subtitulo_atras2 db "(2) ATRAS", "$"
subtitulo_atras4 db "(4) ATRAS", "$"
subtitulo_atras5 db "(5) ATRAS", "$"
portada_productos db "            MENU PRODUCTOS", "$"
portada_ventas db "            MENU VENTAS", "$"
portada_herramientas db "            MENU HERRAMIENTAS", "$"
;;VENTAS
titulo_ventas db "(2) OPCIONES DE VENTA", "$"
subtitulo_ventas1 db "(1) INGRESA LOS DATOS DE LA VENTA","$"
datos_venta db "DATOS VENTA", "$"
;;HERRAMIENTAS
titulo_herramientas db "(3) OPCIONES DE HERRAMIENTAS DEL SISTEMA", "$"
subtitulo_herramientas1 db "(1) GENERAR CATALOGO", "$"
subtitulo_herramientas2 db "(2) REPORTE PRODUCTOS", "$"
subtitulo_herramientas3 db "(3) REPORTE VENTAS", "$"
subtitulo_herramientas4 db "(4) REPORTE PRODUCTOS SIN EXISTENCIA", "$"
;;SALIR
titulo_salir db "(4) SALIR DEL SISTEMA", "$"

;;REPORTE CATALOGO
reporte1 db "SE HA GENERADO EL CATALOGO EXITOSAMENTE", "$"
;;REPORTE PRODUCTOS
reporte2 db "SE HA GENERADO EL REPORTE DE PRODUCTOS EXITOSAMENTE", "$"
;;REPORTE VENTAS
reporte3 db "SE HA GENERADO EL REPORTE DE VENTAS EXITOSAMENTE", "$"
;;REPORTE PRODUCTOS SIN EXISTENCIA
reporte4 db "SE HA GENERADO EL REPORTE DE PRODUCTOS SIN EXISTENCIA EXITOSAMENTE", "$"
;;SOLICITAR INGRESO DE DATOS MENU
ingreso_menu db "INGRESA LA OPCION DEL MENU QUE DESEAS UTILIZAR: ", "$"

;;INGRESO DE DATOS INCORRECTO
ingreso_menu_error db "OPCION DEL MENU INGRESADA ERRONEA ", "$"

;;MENSAJE PRESIONAR ENTER
msg_enter db "-> Presione Enter para continuar...","$"

;;NOMBRE DEL ARCHIVO DE LAS CREDENCIALES
archivo_credenciales db "vacas/pra2/PRA2.CNF",00


;;BUFFER          20 = 32bytes  tam_cadena = 00
buffer_entrada   db  20, 00
                 db  20 dup (0)

;;MANEJADOR O PUNTERO DEL ARCHIVO
handle_creds dw 0000

;;ARCHIVO CREDENCIALES ERROR
error_archivo_credenciales db "ERROR, EL ARCHIVO DE CREDENCIALES NO EXISTE", "$"

;;ARCHIVO PROD ERROR
crear_archivo_prod db "SE HA CREADO EL ARCHIVO PROD.BIN EXITOSAMENTE", "$"
error_crear_archivo_prod db "ERROR, EL ARCHIVO NO HA SIDO CREADO", "$"

error_lectura_archivo_prod db "ERROR, NO SE PUDO ABRIR EL ARCHIVO DE PRODUCTOS", "$"

;;ESTRUCTURA DATOS CREDENCIALES
usu db 'usuario = "cpolanco"', '$'
cla db 'clave = "201709282"', '$'

encabezado_cred db 0f dup(0), "$" ;;15 bytes contando caracteres especiales
usuario_cred db 15 dup(0), "$" ;;21 bytes contando caracteres especiales
clave_cred db 14 dup(0), "$";;20 bytes contando caracteres especiales

success_login db "CREDENCIALES CORRECTAS", "$"

error_usu db "EL USUARIO INGRESADO ES INCORRECTO", "$"
error_clave db "LA CLAVE INGRESADA ES INCORRECTA", "$"

validate_user db "VALIDANDO USUARIO", "$"
validate_key db "VALIDANDO CLAVE", "$"

;;SOLICITAR DATOS DEL PRODUCTO
prompt_cod db "INGRESA EL CODIGO DEL PRODUCTO: ", "$"
prompt_des db "INGRESA LA DESCRIPCION DEL PRODUCTO: ", "$"
prompt_precio db "INGRESA EL PRECIO DEL PRODUCTO: ", "$"
prompt_unidades db "INGRESA LAS UNIDADES DISPONIBLES DEL PRODUCTO: ", "$"
error_prompt_cod db "ERROR AL INGRESAR EL CODIGO DEL PRODUCTO", "$"
error_prompt_des db "ERROR AL INGRESAR LA DESCRIPCION DEL PRODUCTO", "$"
error_prompt_precio db "ERROR AL INGRESAR EL PRECIO DEL PRODUCTO", "$"
error_prompt_unidades db "ERROR AL INGRESAR LAS UNIDADES DEL PRODUCTO", "$"

;; "ESTRUCTURA PRODUCTO" tamaño total de 40 bytes 28H
cod_prod    db    05 dup (0) ;;tamaño 4 bytes
des_prod    db    21 dup (0) ;;tamaño 32 bytes
price_prod   db    05 dup (0) ;;tamaño 2 bytes
units_prod   db    05 dup (0) ;;tamaño 2 bytes
            db '$'
;; archivo productos MANEJADOR Y NOMBRE
archivo_prods    db   "vacas/pra2/PROD.BIN",00
handle_prods     dw   0000

;;buffer del numero para la conversion
numero           db   05 dup (30)
;; numéricos
num_price   dw    0000
num_units   dw    0000

;;; temps
cod_prod_temp    db    05 dup (0)
puntero_temp     dw    0000          
ceros          db     2b  dup (0)
;;mensaje de escritura de archivo
msj_escribiendo db "ESCRIBIENDO EN EL ARCHIVO... ", "$"
error_write_file_prod db "ERROR AL ESCRIBIR LOS PRODUCTOS EN EL ARCHIVO...", "$"
.code 
    main proc
        mov AX, @data
        mov DS, AX

        ;;INICIA EL CODIGO DEL PROGRAMA
        mov DX, offset nl
		mov AH, 09
		int 21
        mov DX, offset usac         ; Impresión de datos personales
		mov AH, 09
		int 21
        ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset curso
		mov AH, 09
		int 21
         ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset seccion
		mov AH, 09
		int 21
         ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset periodo
		mov AH, 09
		int 21
         ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset nombre
		mov AH, 09
		int 21
         ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
        mov DX, offset linea_div
		mov AH, 09
		int 21
         ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
        jmp menu_principal
    main endp

            

    menu_principal proc
        ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
        ;;imprimir titulo
        mov DX, offset titulo_menu
        mov AH, 09
        int 21
        ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset titulo_productos
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21;;imprimir titulo
        mov DX, offset titulo_ventas
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset titulo_herramientas
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset titulo_salir
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;INGRESO POR TECLADO
		mov DX, offset ingreso_menu
		mov AH, 09
		int 21
		mov AH, 01
		int 21
		cmp AL, 31
		je menu_productos
		cmp AL, 32
		je menu_venta
		cmp AL, 33
		je menu_herramientas
		cmp AL, 34
		je fin
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset ingreso_menu_error
		mov AH, 09
		int 21
		jmp	menu_principal
    menu_principal endp

    ;;IMPRIMIR MENU PRODUCTOS
    menu_productos proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		 ;;imprimir titulo
        mov DX, offset portada_productos
        mov AH, 09
        int 21
        ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo ingresar producto
        mov DX, offset subtitulo_productos1
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21;;imprimir titulo eliminar producto
        mov DX, offset subtitulo_productos2
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo ver productos
        mov DX, offset subtitulo_productos3
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo atras
        mov DX, offset subtitulo_atras4
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset ingreso_menu
		mov AH, 09
		int 21
		mov AH, 01
		int 21
		;;OPCIONES DE SUBMENU
		cmp AL, 31
		je ingresar_producto
		cmp AL, 32
		je eliminar_producto
		cmp AL, 33
		je ver_productos
		cmp AL, 34
		je menu_principal
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset ingreso_menu_error
		mov AH, 09
		int 21
		jmp menu_productos
    menu_productos endp

    ;;OPCION VENTAS
    menu_venta proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		 ;;imprimir titulo
        mov DX, offset portada_ventas
        mov AH, 09
        int 21
        ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		 ;;imprimir titulo
        mov DX, offset subtitulo_ventas1
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		 ;;imprimir titulo
        mov DX, offset subtitulo_atras2
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;INGRESO POR TECLADO
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset ingreso_menu
		mov AH, 09
		int 21
		mov AH, 01
		int 21
		cmp AL, 31
		je realizar_venta
		cmp AL, 32
		je menu_principal
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset ingreso_menu_error
		mov AH, 09
		int 21
		jmp menu_venta
    menu_venta endp

    ;;OPCION HERRAMIENTAS
    menu_herramientas proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		 ;;imprimir titulo
        mov DX, offset portada_herramientas
        mov AH, 09
        int 21
        ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo generar catalogo
        mov DX, offset subtitulo_herramientas1
        mov AH, 09
        int 21
		;;nueva linea 
        mov DX, offset nl
		mov AH, 09
		int 21;;imprimir titulo reporte productos
        mov DX, offset subtitulo_herramientas2
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo reporte de ventas
        mov DX, offset subtitulo_herramientas3
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo reporte productos sin existencia
        mov DX, offset subtitulo_herramientas4
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo atras
        mov DX, offset subtitulo_atras5
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;INGRESO POR TECLADO
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset ingreso_menu
		mov AH, 09
		int 21
		mov AH, 01
		int 21
		;;INGRESO DE OPCIONES DE MENU DE HERRAMIENTAS
		cmp AL, 31
		je reporte_catalogo
		cmp AL, 32
		je reporte_productos
		cmp AL, 33
		je reporte_ventas
		cmp AL, 34
		je reporte_productos_null
		cmp AL, 35
		je menu_principal
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		mov DX, offset ingreso_menu_error
		mov AH, 09
		int 21
		jmp menu_herramientas
    menu_herramientas endp

    ;;INGRESAR UN PRODUCTO
    ingresar_producto proc
        ;;nueva linea
        mov DX, offset nl
        mov AH, 09
        int 21
        ;;imprimir titulo
        mov DX, offset ingresar_prod
        mov AH, 09
        int 21
        ;;nueva linea
        mov DX, offset nl
        mov AH, 09
        int 21

        prueba_open_file:
            ;;ABRIR ARCHIVO
            mov AL, 02
            mov AH, 3d
            mov DX, offset archivo_prods
            int 21
            jc crear_archivo_producto
            jmp guardar_handle_prod
        ;;CREAR ARCHIVO SI NO EXISTE SUBRUTINA
        crear_archivo_producto:
            ;;CREAR ARCHIVO
            mov CX, 0000
            mov DX, offset archivo_prods
            mov AH, 3c
            int 21
            jc fin 
            jmp guardar_handle_prod
        guardar_handle_prod:
            mov [handle_prods], AX
        ;;INGRESAR DATOS DEL PRODUCTO:

        ;;CODIGO
        ingreso_cod_productos:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset prompt_cod
            mov AH, 09
            int 21
            ;;INGRESAR CODIGO
            mov DX, offset buffer_entrada
            mov AH, 0a
            int 21
            ;;VALIDAR TAMAÑO
            mov DI, offset buffer_entrada
            ;;sumamos 1 al buffer para obtener el tamaño de la entrada
            inc DI
            ;;guardamos el valor
            mov AL, [DI]
            ;;verificar si la entrada viene vacia
            cmp AL, 00
            je error_ingresar_cod 
            ;;verificar el tamaño este en el rango designado
            cmp AL, 05
            jb validar_entrada_cod
            ;;SI ES MAYOR SALTA AL ERROR Y SOLICITA DE NUEVO EL CODIGO 
            mov DX, offset nl 
            mov AH, 09
            int 21
            jmp error_ingresar_cod
        ;;VALIDAR LOS CARACTERES DE LA ENTRADA
        validar_entrada_cod:
            mov SI, offset cod_prod
            mov DI, offset buffer_entrada
            inc DI ;; me posiciono en el tamaño de la cadena
            mov CH, 00
            mov CL, [DI]
            inc DI  ;; me posiciono en el contenido del buffer
        copiar_cod:
            ;;VALIDAR QUE VENGAN LOS CARACTERES CORRECTOS
            mov AL, [DI] ;;guardo el contenido del buffer
            cmp AL, 30 ;; COMPARA CON EL NUMERO <0>
            jb error_ingresar_cod
            cmp AL, 39 ;; COMPARA CON EL NUMERO <9>
            Ja validar_letra_cod
            jmp codigo_copiado
        validar_letra_cod:
            cmp AL, 41 ;;COMPARA CON LA LETRA <A>
            jb error_ingresar_cod 
            cmp AL, 5a ;;COMPARA CON LA LETRA <Z>
            ja error_ingresar_cod
        codigo_copiado:
            mov [SI], AL
            inc SI
            inc DI
            loop copiar_cod ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
            ;;; la cadena ingresada en la estructura
            ;;;
            mov DX, offset nl
            mov AH, 09
            int 21	
            jmp ingreso_des_productos
        ;;ERROR AL INGRESAR EL CODIGO
        error_ingresar_cod:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset error_prompt_cod
            mov AH, 09
            int 21
            jmp ingreso_cod_productos

        ;;DESCRIPCION
        ingreso_des_productos:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset prompt_des
            mov AH, 09
            int 21
            ;;INGRESAR CODIGO
            mov DX, offset buffer_entrada
            mov AH, 0a
            int 21
            ;;VALIDAR TAMAÑO
            mov DI, offset buffer_entrada
            ;;sumamos 1 al buffer para obtener el tamaño de la entrada
            inc DI
            ;;guardamos el valor
            mov AL, [DI]
            ;;verificar si la entrada viene vacia
            cmp AL, 00
            je error_ingresar_des 
            ;;verificar el tamaño este en el rango designado
            cmp AL, 21
            jb validar_entrada_des
            ;;SI ES MAYOR SALTA AL ERROR Y SOLICITA DE NUEVO LA DESCRIPCION
            mov DX, offset nl 
            mov AH, 09
            int 21
            jmp error_ingresar_des
        ;;VALIDAR LOS CARACTERES DE LA ENTRADA
        validar_entrada_des:
            mov SI, offset des_prod
            mov DI, offset buffer_entrada
            inc DI ;; me posiciono en el tamaño de la cadena
            mov CH, 00
            mov CL, [DI]
            inc DI  ;; me posiciono en el contenido del buffer
        copiar_des:
            ;;VALIDAR QUE VENGAN LOS CARACTERES CORRECTOS
            mov AL, [DI] ;;guardo el contenido del buffer
            cmp AL, 30 ;; COMPARA CON EL NUMERO <0>
            jb validar_caracteres_des
            cmp AL, 39 ;; COMPARA CON EL NUMERO <9>
            Ja validar_letra_des
            jmp des_copiado
        validar_caracteres_des:
            cmp AL, 20 ;;COMPARA CON EL CARACTER < > "espacio en blanco"
            je des_copiado
            cmp AL, 21 ;;COMPARA CON EL CARACTER <!>
            je des_copiado
            cmp AL, 2c ;;COMPARA CON EL CARACTER <,>
            je des_copiado
            cmp AL, 2e ;;COMPARA CON EL CARACTER <.>
            je des_copiado
            jmp error_ingresar_des
        validar_letra_des:
            cmp AL, 41 ;;COMPARA CON LA LETRA <A>
            jb error_ingresar_des 
            cmp AL, 5a ;;COMPARA CON LA LETRA <Z>
            ja validar_letra_min_des
            jmp des_copiado 
        validar_letra_min_des:
            cmp AL, 61 ;;COMPARA CON LA LETRA <a>
            jb error_ingresar_des 
            cmp AL, 7a ;;COMPARA CON LA LETRA <z>
            ja error_ingresar_des
        des_copiado:
            mov [SI], AL
            inc SI
            inc DI
            loop copiar_des ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
            ;;; la cadena ingresada en la estructura
            mov DX, offset nl
            mov AH, 09
            int 21	
            jmp ingreso_precio_productos
        ;;ERROR AL INGRESAR LA DESCRIPCION
        error_ingresar_des:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset error_prompt_des
            mov AH, 09
            int 21
            jmp ingreso_des_productos

        ;;PRECIO
        ingreso_precio_productos:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset prompt_precio
            mov AH, 09
            int 21
            ;;INGRESAR CODIGO
            mov DX, offset buffer_entrada
            mov AH, 0a
            int 21
            ;;VALIDAR TAMAÑO
            mov DI, offset buffer_entrada
            ;;sumamos 1 al buffer para obtener el tamaño de la entrada
            inc DI
            ;;guardamos el valor
            mov AL, [DI]
            ;;verificar si la entrada viene vacia
            cmp AL, 00
            je error_ingresar_precio 
            ;;verificar el tamaño este en el rango designado
            cmp AL, 03
            jb validar_entrada_precio
            ;;SI ES MAYOR SALTA AL ERROR Y SOLICITA DE NUEVO EL CODIGO 
            mov DX, offset nl 
            mov AH, 09
            int 21
            jmp error_ingresar_precio
        ;;VALIDAR LOS CARACTERES DE LA ENTRADA
        validar_entrada_precio:
            mov SI, offset price_prod
            mov DI, offset buffer_entrada
            inc DI ;; me posiciono en el tamaño de la cadena
            mov CH, 00
            mov CL, [DI]
            inc DI  ;; me posiciono en el contenido del buffer
        copiar_precio:
            ;;VALIDAR QUE VENGAN LOS CARACTERES CORRECTOS
            mov AL, [DI] ;;guardo el contenido del buffer
            cmp AL, 30 ;; COMPARA CON EL NUMERO <0>
            jb error_ingresar_precio
            cmp AL, 39 ;; COMPARA CON EL NUMERO <9>
            Ja error_ingresar_precio
            mov [SI], AL
            inc SI
            inc DI
            loop copiar_precio ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
            ;;; la cadena ingresada en la estructura
            ;;;TRATAMIENTO ESPECIAL PARA NUMEROS, PASAR A CADENA
            ;;
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;
            mov DI, offset price_prod
            call cadenaAnum
            ;; AX -> numero convertido
            mov [num_price], AX
            ;;
            mov DI, offset price_prod
            mov CX, 0005
            call memset	

            jmp ingreso_units_productos

        ;;ERROR AL INGRESAR EL PRECIO
        error_ingresar_precio:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset error_prompt_precio
            mov AH, 09
            int 21
            jmp ingreso_precio_productos


        ;;UNIDADES DISPONIBLES
        ingreso_units_productos:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset prompt_unidades
            mov AH, 09
            int 21
            ;;INGRESAR CODIGO
            mov DX, offset buffer_entrada
            mov AH, 0a
            int 21
            ;;VALIDAR TAMAÑO
            mov DI, offset buffer_entrada
            ;;sumamos 1 al buffer para obtener el tamaño de la entrada
            inc DI
            ;;guardamos el valor
            mov AL, [DI]
            ;;verificar si la entrada viene vacia
            cmp AL, 00
            je error_ingresar_units 
            ;;verificar el tamaño este en el rango designado
            cmp AL, 03
            jb validar_entrada_units
            ;;SI ES MAYOR SALTA AL ERROR Y SOLICITA DE NUEVO EL CODIGO 
            mov DX, offset nl 
            mov AH, 09
            int 21
            jmp error_ingresar_units
        ;;VALIDAR LOS CARACTERES DE LA ENTRADA
        validar_entrada_units:
            mov SI, offset units_prod
            mov DI, offset buffer_entrada
            inc DI ;; me posiciono en el tamaño de la cadena
            mov CH, 00
            mov CL, [DI]
            inc DI  ;; me posiciono en el contenido del buffer
        copiar_units:
            ;;VALIDAR QUE VENGAN LOS CARACTERES CORRECTOS
            mov AL, [DI] ;;guardo el contenido del buffer
            cmp AL, 30 ;; COMPARA CON EL NUMERO <0>
            jb error_ingresar_units
            cmp AL, 39 ;; COMPARA CON EL NUMERO <9>
            Ja error_ingresar_units
            mov [SI], AL
            inc SI
            inc DI
            loop copiar_units ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
            ;;; la cadena ingresada en la estructura
            ;;;TRATAMIENTO ESPECIAL PARA NUMEROS, PASAR A CADENA
            ;;
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;
            mov DI, offset units_prod
            call cadenaAnum
            ;; AX -> numero convertido
            mov [num_units], AX
            ;;
            mov DI, offset units_prod
            mov CX, 0005
            call memset
            jmp escribir_productos_archivo
            ;;ERROR AL INGRESAR LAS UNIDADES DISPONIBLES
        error_ingresar_units:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset error_prompt_unidades
            mov AH, 09
            int 21
            jmp ingreso_units_productos
        escribir_productos_archivo:
            ;;Mover el manejador de archivos a BX
            mov BX, [handle_prods]
            ;; MOVER PUNTERO AL FINAL DEL ARCHIVO
            mov CX, 00
            mov DX, 00
            mov AL, 02
            mov AH, 42
            int 21
            ;;CODIGO
            mov CX, 26
            mov DX, offset cod_prod
            mov AH, 40
            int 21
            ;;PRECIO
            mov CX, 04
            mov DX, offset num_price
            mov AH, 40
            int 21
            ;; cerrar archivo
            mov AH, 3e
            int 21
            ;;
            jmp menu_productos

        
    ingresar_producto endp
    

    ;;ELIMINAR PRODUCTO
    eliminar_producto proc
        mov AX, @data
        mov DS, AX
        
    	;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset eliminar_prod
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
        eliminar_producto_archivo:
                mov DX, 0000
                mov [puntero_temp], DX
        pedir_de_nuevo_codigo2:
                mov DX, offset prompt_cod
                mov AH, 09
                int 21
                mov DX, offset buffer_entrada
                mov AH, 0a
                int 21
                ;;
                mov DI, offset buffer_entrada
                inc DI
                mov AL, [DI]
                cmp AL, 00
                je  pedir_de_nuevo_codigo2 ;;validar si viene vacia la entrada
                cmp AL, 05 ;;si viene una entrada, valida el tamaño
                jb  aceptar_tam_cod2  ;; jb --> jump if below x < 4
                mov DX, offset nl
                mov AH, 09
                int 21
                jmp pedir_de_nuevo_codigo2;;si el tamaño es mayor a 4 bytes pide de nuevo el codigo
                ;;; mover al campo codigo en la estructura producto
        aceptar_tam_cod2:
                mov SI, offset cod_prod_temp
                mov DI, offset buffer_entrada
                inc DI ;;se mueve al tamaño de la cadena de entrada
                mov CH, 00
                mov CL, [DI]
                inc DI  ;; me posiciono en el contenido del buffer
        copiar_codigo2:	mov AL, [DI]
                mov [SI], AL
                inc SI
                inc DI
                loop copiar_codigo2  ;; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
                ;;; la cadena ingresada en la estructura
                ;;;
                mov DX, offset nl
                mov AH, 09
                int 21
                ;;
                mov AL, 02              ;;;<<<<<  lectura/escritura
                mov DX, offset archivo_prods
                mov AH, 3d
                int 21
                mov [handle_prods], AX
                ;;; TODO: revisar si existe
        ciclo_encontrar:
                mov BX, [handle_prods]
                mov CX, 26
                mov DX, offset cod_prod
                moV AH, 3f
                int 21
                mov BX, [handle_prods]
                mov CX, 4
                mov DX, offset num_price
                moV AH, 3f
                int 21
                cmp AX, 0000   ;; se acaba cuando el archivo se termina
                je finalizar_borrar
                ;;SE LLENA CON CEROS EL TEMPORAL
                mov DX, [puntero_temp]
                add DX, 2a
                mov [puntero_temp], DX
                ;;; verificar si es producto válido
                mov AL, 00
                cmp [cod_prod], AL
                je ciclo_encontrar
                ;;; verificar el código
                mov SI, offset cod_prod_temp
                mov DI, offset cod_prod
                mov CX, 0005
                call cadenas_iguales
                ;;;; <<
                cmp DL, 0ff
                je borrar_encontrado
                jmp ciclo_encontrar
        borrar_encontrado:
                mov DX, [puntero_temp]
                sub DX, 2a
                mov CX, 0000
                mov BX, [handle_prods]
                mov AL, 00
                mov AH, 42
                int 21
                ;;; puntero posicionado ESCRIBIR LOS 0 EN EL ESPACIO EN BLANCO
                mov CX, 2a
                mov DX, offset ceros
                mov AH, 40
                int 21
        finalizar_borrar:
                mov BX, [handle_prods]
                mov AH, 3e
                int 21
                jmp menu_productos
    eliminar_producto endp

    ver_productos proc
        ;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset ver_prod
        mov AH, 09
        int 21
		
        mov DX, offset nl
		mov AH, 09
		int 21
        mov DX, offset nl
		mov AH, 09
		int 21
		;;
		mov AL, 02
		mov AH, 3d
		mov DX, offset archivo_prods
		int 21
        jc error_lectura_archivo_productos
		;;
		mov [handle_prods], AX
		;; leemos
        ciclo_mostrar:
            ;; puntero cierta posición
            mov BX, [handle_prods]
            mov CX, 0026     ;; leer 26h bytes
            mov DX, offset cod_prod
            ;;
            mov AH, 3f
            int 21
            mov BX, [handle_prods]
            mov CX, 0004
            mov DX, offset num_price
            mov AH, 3f
            int 21
            cmp AX, 0000
            je fin_mostrar
            ;; ver si es producto válido
            mov AL, 00
            cmp [cod_prod], AL
            je ciclo_mostrar
            ;; producto en estructura
            call imprimir_estructura         
            jmp ciclo_mostrar
            ;;
        fin_mostrar:
            jmp menu_productos
        error_lectura_archivo_productos:
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            ;;imprimir titulo
            mov DX, offset error_lectura_archivo_prod
            mov AH, 09
            int 21
            ;;nueva linea
            mov DX, offset nl
            mov AH, 09
            int 21
            jmp fin
    ver_productos endp

    ;;REALIZAR VENTA
    realizar_venta proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset datos_venta
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		jmp fin
    realizar_venta endp

    ;;REPORTE CATALOGO
    reporte_catalogo proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset reporte1
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		jmp fin
    reporte_catalogo endp

    ;;REPORTE PRODUCTOS
    reporte_productos proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset reporte2
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		jmp fin
    reporte_productos endp

    ;;REPORTE VENTAS
    reporte_ventas proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset reporte3
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		jmp fin
    reporte_ventas endp

    ;;REPORTE PRODUCTO SIN EXISTENCIA
    reporte_productos_null proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset reporte4
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		jmp fin
    reporte_productos_null endp

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; imprimir_estructura - ...
;; ENTRADAS:
;; SALIDAS:
;;     o Impresión de estructura
    imprimir_estructura proc
		mov DI, offset cod_prod 
        ciclo_poner_dolar_1:
            mov AL, [DI]
            cmp AL, 00
            je poner_dolar_1
            inc DI
            jmp ciclo_poner_dolar_1
        poner_dolar_1:
            mov AL, 24  ;; dólar
            mov [DI], AL
            ;; imprimir normal
            mov DX, offset cod_prod
            mov AH, 09
            int 21
            mov DX, offset nl
            mov AH, 09
            int 21
            mov DX, offset des_prod
            mov AH, 09
            int 21
            mov DX, offset nl
            mov AH, 09
            int 21
		mov DX, offset nl
		mov AH, 09
		int 21
        ret
    imprimir_estructura endp

    ;; esperar_enter - espera que se presione enter para continuar              [SUBRUTINA]
    ;; Entrada - ninguna
    ;; Salida  - ninguna
    esperar_enter proc
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21
		;;imprimir titulo
        mov DX, offset msg_enter
        mov AH, 09
        int 21
		;;nueva linea
        mov DX, offset nl
		mov AH, 09
		int 21	
		mov AH, 08
		int 21
		cmp AL, 0d
		jne esperar_enter
		ret
    esperar_enter endp

    ;;SUBRUTINA PARA PASAR CADENA A NUMERO
    cadenaAnum proc
            mov AX, 0000    ; inicializar la salida
            mov CX, 0005    ; inicializar contador
            ;;
        seguir_convirtiendo:
                mov BL, [DI]
                cmp BL, 00
                je retorno_cadenaAnum
                sub BL, 30      ; BL es el valor numérico del caracter
                mov DX, 000a
                mul DX          ; AX * DX -> DX:AX
                mov BH, 00
                add AX, BX 
                inc DI          ; puntero en la cadena
                loop seguir_convirtiendo
        retorno_cadenaAnum:
                ret
    cadenaAnum endp

    ;;SUBRUTINA PARA PASAR DE NUMERO A CADENA
    numAcadena proc
		mov CX, 0005
		mov DI, offset numero
        ciclo_poner30s:
                mov BL, 30
                mov [DI], BL
                inc DI
                loop ciclo_poner30s
                ;; tenemos "0" en toda la cadena
                mov CX, AX    ; inicializar contador
                mov DI, offset numero
                add DI, 0004
                ;;
        ciclo_convertirAcadena:
                mov BL, [DI]
                inc BL
                mov [DI], BL
                cmp BL, 3a
                je aumentar_siguiente_digito_primera_vez
                loop ciclo_convertirAcadena
                jmp retorno_convertirAcadena
        aumentar_siguiente_digito_primera_vez:
                push DI
        aumentar_siguiente_digito:
                mov BL, 30     ; poner en "0" el actual
                mov [DI], BL
                dec DI         ; puntero a la cadena
                mov BL, [DI]
                inc BL
                mov [DI], BL
                cmp BL, 3a
                je aumentar_siguiente_digito
                pop DI         ; se recupera DI
                loop ciclo_convertirAcadena
        retorno_convertirAcadena:
                ret
    numAcadena endp

    ;; cadenas_iguales -
;; ENTRADA:
;;    SI -> dirección a cadena 1
;;    DI -> dirección a cadena 2
;;    CX -> tamaño máximo
;; SALIDA:
;;    DL -> 00 si no son iguales

;;         0ff si si lo son
    cadenas_iguales proc
        ciclo_cadenas_iguales:
                mov AL, [SI]
                cmp [DI], AL
                jne no_son_iguales
                inc DI
                inc SI
                loop ciclo_cadenas_iguales
                ;;;;; <<<
                mov DL, 0ff
                ret
        no_son_iguales:	mov DL, 00
                ret
    cadenas_iguales endp
        ;; memset
    ;; ENTRADA:
    ;;    DI -> dirección de la cadena
    ;;    CX -> tamaño de la cadena
    memset proc
    ciclo_memset:
            mov AL, 00
            mov [DI], AL
            inc DI
            loop ciclo_memset
            ret
    memset endp

    fin proc
        ;;interrupcion de finalizacion del programa
        mov ah, 4c 
        int 21
    fin endp

end main
