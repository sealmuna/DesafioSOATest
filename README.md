Configurar conexión JDBC en SOAtest

Este README explica brevemente cómo configurar una conexión JDBC en Parasoft SOAtest para poder ejecutar las consultas utilizadas a la base de datos.




1\. Descarga de driver JDBC


* Descargar el driver de MySQL desde el sitio oficial de MySQL https://dev.mysql.com/downloads/connector/j/
* El driver utilizado es Connector/J 9.7.0




2\. Registrar el driver en SOAtest


* Abre SOAtest.
* Ve a Parasoft > Preferences.
* Selecciona Parasoft > JDBC Drivers.
* Haz clic en New > Browse y seleccionar el archivo .jar descargado y dar click en OK.
* Aplicar cambios.




3\. Crear base de datos MySQL en localhost


* Se debe crear la base de datos con el siguiente script:


-- Base de datos: `desafio`
--
-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `captura_pokemon`
--


CREATE TABLE `captura_pokemon` (

	`pokemon_name` varchar(100) NOT NULL,

	`id_transaccion` int(5) NOT NULL,

	`fecha` varchar(30) NOT NULL

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




4\. Configurar la conexión en DB Tool


* Dentro de DB Tool > Tool Settings, se debe crear la conexión a la base de datos
* Seleccionar la opción Local e ingresar los siguientes datos:

Driver: com.mysql.cj.jdbc.Driver
Connection URL: jdbc:mysql://localhost:3306/desafio
Username: root
Password: (sin password)

* Guardar cambios realizados.

