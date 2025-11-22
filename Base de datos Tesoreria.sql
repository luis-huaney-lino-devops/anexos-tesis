CREATE TABLE `USUARIO` (
  `id_usuario` bigint PRIMARY KEY AUTO_INCREMENT,
  `tipo_documento` varchar(20) NOT NULL,
  `numero_documento` varchar(20) UNIQUE NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellido_paterno` varchar(50) NOT NULL,
  `apellido_materno` varchar(50) NOT NULL,
  `email_institucional` varchar(100) UNIQUE,
  `email_personal` varchar(100),
  `telefono_movil` varchar(15),
  `telefono_fijo` varchar(15),
  `direccion` varchar(200),
  `fecha_nacimiento` date,
  `genero` varchar(1),
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVO',
  `password_hash` varchar(255),
  `ultimo_login` timestamp,
  `intentos_login_fallidos` int DEFAULT 0,
  `cuenta_bloqueada` boolean DEFAULT false,
  `requiere_cambio_password` boolean DEFAULT false,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_modificacion` timestamp,
  `fk_id_usuario_creacion` bigint,
  `fk_id_usuario_modificacion` bigint
);

CREATE TABLE `ESTUDIANTE` (
  `id_estudiante` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint NOT NULL,
  `codigo_estudiante` varchar(20) UNIQUE NOT NULL,
  `fk_id_facultad` int,
  `fk_id_escuela` int,
  `situacion_academica` varchar(30) NOT NULL,
  `becado` boolean DEFAULT false,
  `porcentaje_beca` decimal(5,2) DEFAULT 0,
  `fk_id_tipo_beneficiario` int,
  `fecha_ingreso` date NOT NULL,
  `fecha_egreso` date,
  `promedio_ponderado` decimal(4,2),
  `creditos_aprobados` int DEFAULT 0,
  `ciclo_actual` int,
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVO',
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `DOCENTE` (
  `id_docente` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint NOT NULL,
  `codigo_docente` varchar(20) UNIQUE NOT NULL,
  `categoria` varchar(30) NOT NULL,
  `dedicacion` varchar(30) NOT NULL,
  `nombrado` boolean DEFAULT false,
  `fk_id_departamento` int,
  `especialidad` varchar(100),
  `grado_academico` varchar(50),
  `fecha_ingreso` date NOT NULL,
  `fecha_cese` date,
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVO',
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `PERSONAL_ADMINISTRATIVO` (
  `id_personal_administrativo` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint NOT NULL,
  `codigo_trabajador` varchar(20) UNIQUE NOT NULL,
  `fk_id_area` int,
  `cargo` varchar(100) NOT NULL,
  `nivel_jerarquico` varchar(30),
  `tipo_contrato` varchar(30),
  `fecha_ingreso` date NOT NULL,
  `fecha_cese` date,
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVO',
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `PROVEEDOR` (
  `id_proveedor` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint,
  `tipo_proveedor` varchar(20) NOT NULL,
  `ruc` varchar(11) UNIQUE,
  `razon_social` varchar(200),
  `nombre_comercial` varchar(200),
  `categoria_proveedor` varchar(50),
  `tipo_persona` varchar(20) NOT NULL,
  `estado_sunat` varchar(30),
  `condicion_domicilio` varchar(30),
  `direccion_fiscal` varchar(300),
  `ubigeo` varchar(6),
  `representante_legal` varchar(150),
  `telefono_contacto` varchar(15),
  `email_contacto` varchar(100),
  `calificacion` decimal(3,2),
  `activo` boolean DEFAULT true,
  `fecha_registro` date NOT NULL,
  `fecha_ultima_operacion` date,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `ROL` (
  `id_rol` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `nivel_acceso` int NOT NULL,
  `modulo` varchar(50),
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `USUARIO_ROL` (
  `id_usuario_rol` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint NOT NULL,
  `fk_id_rol` int NOT NULL,
  `fecha_vigencia_inicio` date NOT NULL,
  `fecha_vigencia_fin` date,
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVO',
  `fecha_asignacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_asigna` bigint,
  `observaciones` text
);

CREATE TABLE `PERMISO` (
  `id_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(100) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text,
  `modulo` varchar(50) NOT NULL,
  `recurso` varchar(100),
  `accion` varchar(50) NOT NULL,
  `tipo_permiso` varchar(30) NOT NULL,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `ROL_PERMISO` (
  `id_rol_permiso` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_rol` int NOT NULL,
  `fk_id_permiso` int NOT NULL,
  `fecha_asignacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_asigna` bigint
);

CREATE TABLE `SESION` (
  `id_sesion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint NOT NULL,
  `token_sesion` varchar(500) UNIQUE NOT NULL,
  `ip_origen` varchar(45) NOT NULL,
  `navegador` varchar(200),
  `sistema_operativo` varchar(100),
  `dispositivo` varchar(50),
  `ubicacion_geografica` varchar(100),
  `fecha_inicio` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_ultima_actividad` timestamp,
  `fecha_cierre` timestamp,
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVA',
  `duracion_segundos` int
);

CREATE TABLE `PERSONA_NATURAL_RENIEC` (
  `id_persona_reniec` bigint PRIMARY KEY AUTO_INCREMENT,
  `dni` varchar(8) UNIQUE NOT NULL,
  `nombres` varchar(100),
  `apellido_paterno` varchar(50),
  `apellido_materno` varchar(50),
  `fecha_nacimiento` date,
  `ubigeo_nacimiento` varchar(6),
  `ubigeo_domicilio` varchar(6),
  `direccion` varchar(300),
  `estado_civil` varchar(20),
  `sexo` varchar(1),
  `fecha_consulta` timestamp NOT NULL,
  `respuesta_json` text,
  `valido` boolean DEFAULT true
);

CREATE TABLE `PERSONA_JURIDICA_SUNAT` (
  `id_persona_sunat` bigint PRIMARY KEY AUTO_INCREMENT,
  `ruc` varchar(11) UNIQUE NOT NULL,
  `razon_social` varchar(300),
  `nombre_comercial` varchar(300),
  `tipo_contribuyente` varchar(50),
  `estado` varchar(30),
  `condicion` varchar(30),
  `direccion` varchar(500),
  `ubigeo` varchar(6),
  `departamento` varchar(50),
  `provincia` varchar(50),
  `distrito` varchar(50),
  `fecha_inscripcion` date,
  `fecha_inicio_actividades` date,
  `actividad_economica` varchar(300),
  `sistema_emision_comprobante` varchar(50),
  `sistema_contabilidad` varchar(50),
  `fecha_consulta` timestamp NOT NULL,
  `respuesta_json` text,
  `valido` boolean DEFAULT true
);

CREATE TABLE `CATEGORIA_CONCEPTO` (
  `id_categoria_concepto` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CONCEPTO_INGRESO` (
  `id_concepto_ingreso` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text,
  `fk_id_categoria_concepto` int NOT NULL,
  `clasificador_siaf` varchar(20) NOT NULL,
  `tipo_concepto` varchar(30) NOT NULL,
  `requiere_periodo_academico` boolean DEFAULT false,
  `genera_mora` boolean DEFAULT false,
  `porcentaje_mora` decimal(5,2) DEFAULT 0,
  `dias_gracia` int DEFAULT 0,
  `permite_descuento` boolean DEFAULT true,
  `permite_fraccionamiento` boolean DEFAULT false,
  `monto_minimo_fraccionamiento` decimal(10,2),
  `prioridad_cobro` int DEFAULT 5,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `PERIODO_ACADEMICO` (
  `id_periodo_academico` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(20) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `anio` int NOT NULL,
  `numero_periodo` int NOT NULL,
  `tipo_periodo` varchar(20) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `TIPO_BENEFICIARIO` (
  `id_tipo_beneficiario` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `porcentaje_descuento_base` decimal(5,2) DEFAULT 0,
  `requiere_documentacion` boolean DEFAULT false,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `DESCUENTO` (
  `id_descuento` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `tipo_descuento` varchar(30) NOT NULL,
  `porcentaje_descuento` decimal(5,2),
  `monto_fijo` decimal(10,2),
  `fk_id_tipo_beneficiario` int,
  `fecha_vigencia_inicio` date NOT NULL,
  `fecha_vigencia_fin` date,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `TUPA` (
  `id_tupa` int PRIMARY KEY AUTO_INCREMENT,
  `codigo_procedimiento` varchar(50) UNIQUE NOT NULL,
  `nombre_procedimiento` varchar(200) NOT NULL,
  `descripcion` text,
  `fk_id_concepto_ingreso` int NOT NULL,
  `monto_uit` decimal(5,2) NOT NULL,
  `monto_soles` decimal(10,2) NOT NULL,
  `valor_uit_referencia` decimal(10,2) NOT NULL,
  `anio_vigencia` int NOT NULL,
  `fecha_vigencia_inicio` date NOT NULL,
  `fecha_vigencia_fin` date,
  `numero_resolucion` varchar(100),
  `fecha_resolucion` date,
  `documento_sustento_url` varchar(500),
  `requiere_actualizacion_automatica` boolean DEFAULT true,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `ACTUALIZACION_TARIFARIO` (
  `id_actualizacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_tupa` int NOT NULL,
  `fk_id_tarifario` int NOT NULL,
  `valor_uit_anterior` decimal(10,2) NOT NULL,
  `valor_uit_nuevo` decimal(10,2) NOT NULL,
  `monto_anterior` decimal(10,2) NOT NULL,
  `monto_nuevo` decimal(10,2) NOT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `tipo_actualizacion` varchar(30) NOT NULL,
  `motivo` text,
  `numero_resolucion` varchar(100),
  `automatica` boolean DEFAULT true,
  `fk_id_usuario_aprueba` bigint,
  `estado` varchar(20) NOT NULL DEFAULT 'APLICADO'
);

CREATE TABLE `TARIFARIO` (
  `id_tarifario` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_concepto_ingreso` int NOT NULL,
  `fk_id_tupa` int,
  `anio` int NOT NULL,
  `periodo` varchar(10),
  `fk_id_periodo_academico` int,
  `fk_id_tipo_beneficiario` int,
  `monto_base` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `porcentaje_descuento` decimal(5,2) DEFAULT 0,
  `monto_final` decimal(10,2) NOT NULL,
  `fecha_vigencia_inicio` date NOT NULL,
  `fecha_vigencia_fin` date,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `ORDEN_PAGO_INGRESO` (
  `id_orden_pago_ingreso` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_orden` varchar(50) UNIQUE NOT NULL,
  `fk_id_usuario` bigint NOT NULL,
  `fk_id_concepto_ingreso` int NOT NULL,
  `fk_id_periodo_academico` int,
  `fk_id_tarifario` int,
  `descripcion` text,
  `monto_base` decimal(10,2) NOT NULL,
  `descuento_porcentaje` decimal(5,2) DEFAULT 0,
  `descuento_monto` decimal(10,2) DEFAULT 0,
  `recargo_mora` decimal(10,2) DEFAULT 0,
  `monto_total` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `estado` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_emision` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `fecha_pago` date,
  `dias_vencidos` int DEFAULT 0,
  `codigo_qr` text,
  `url_pago_online` varchar(500),
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `DETALLE_ORDEN_PAGO` (
  `id_detalle_orden_pago` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_orden_pago_ingreso` bigint NOT NULL,
  `numero_item` int NOT NULL,
  `fk_id_concepto_ingreso` int NOT NULL,
  `descripcion_item` varchar(300),
  `cantidad` decimal(10,2) DEFAULT 1,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `descuento_monto` decimal(10,2) DEFAULT 0,
  `monto_neto` decimal(10,2) NOT NULL
);

CREATE TABLE `MEDIO_PAGO` (
  `id_medio_pago` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_medio` varchar(30) NOT NULL,
  `descripcion` text,
  `requiere_validacion_externa` boolean DEFAULT false,
  `tiempo_acreditacion_horas` int DEFAULT 0,
  `comision_porcentaje` decimal(5,2) DEFAULT 0,
  `comision_monto_fijo` decimal(10,2) DEFAULT 0,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `PAGO` (
  `id_pago` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_pago` varchar(50) UNIQUE NOT NULL,
  `fk_id_orden_pago_ingreso` bigint NOT NULL,
  `fk_id_medio_pago` int NOT NULL,
  `monto_pagado` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `fecha_pago` timestamp NOT NULL,
  `numero_operacion` varchar(100),
  `numero_tarjeta_enmascarado` varchar(20),
  `canal` varchar(50),
  `estado` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `fk_id_cuenta_bancaria_universidad` int,
  `fk_id_movimiento_bancario` bigint,
  `fk_id_caja_diaria` int,
  `fk_id_turno_caja` bigint,
  `fecha_conciliacion` timestamp,
  `conciliado_automaticamente` boolean DEFAULT false,
  `codigo_autorizacion` varchar(100),
  `respuesta_pasarela` text,
  `comision_monto` decimal(10,2) DEFAULT 0,
  `monto_neto` decimal(10,2),
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_registro` bigint
);

CREATE TABLE `DETALLE_PAGO_CLASIFICADOR` (
  `id_detalle_pago_clasificador` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_pago` bigint NOT NULL,
  `fk_id_clasificador_ingreso` varchar(20),
  `fk_id_fuente_financiamiento` int,
  `fk_id_meta_presupuestal` int,
  `monto` decimal(10,2) NOT NULL,
  `porcentaje` decimal(5,2),
  `glosa` varchar(500)
);

CREATE TABLE `RECIBO_PAGO` (
  `id_recibo_pago` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_recibo` varchar(50) UNIQUE NOT NULL,
  `fk_id_pago` bigint NOT NULL,
  `fk_id_orden_pago_ingreso` bigint NOT NULL,
  `tipo_comprobante` varchar(30) NOT NULL,
  `serie` varchar(10),
  `numero` varchar(20),
  `numero_completo` varchar(30) UNIQUE,
  `fecha_emision` timestamp NOT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `formato` varchar(20) NOT NULL,
  `ruta_pdf` varchar(500),
  `ruta_xml` varchar(500),
  `hash_documento` varchar(255),
  `codigo_qr` text,
  `estado` varchar(30) NOT NULL DEFAULT 'EMITIDO',
  `fecha_anulacion` timestamp,
  `motivo_anulacion` text,
  `emitido_por` bigint,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `TIPO_DEUDA` (
  `id_tipo_deuda` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `genera_bloqueo_automatico` boolean DEFAULT true,
  `dias_para_bloqueo` int DEFAULT 30,
  `tasa_mora_mensual` decimal(5,2) DEFAULT 1,
  `tasa_mora_diaria` decimal(8,5),
  `permite_plan_pagos` boolean DEFAULT true,
  `requiere_garantia_plan` boolean DEFAULT false,
  `monto_minimo_plan` decimal(10,2),
  `max_cuotas_plan` int DEFAULT 6,
  `prioridad_cobro` int DEFAULT 5,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `ESTADO_DEUDA` (
  `id_estado_deuda` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `permite_pago` boolean DEFAULT true,
  `permite_plan_pagos` boolean DEFAULT true,
  `activo` boolean DEFAULT true
);

CREATE TABLE `DEUDA` (
  `id_deuda` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_deuda` varchar(50) UNIQUE NOT NULL,
  `fk_id_usuario` bigint NOT NULL,
  `fk_id_tipo_deuda` int NOT NULL,
  `fk_id_estado_deuda` int NOT NULL,
  `fk_id_concepto_ingreso` int,
  `fk_id_orden_pago_vencida` bigint,
  `descripcion` text NOT NULL,
  `monto_original` decimal(10,2) NOT NULL,
  `monto_pagado` decimal(10,2) NOT NULL DEFAULT 0,
  `monto_pendiente` decimal(10,2) NOT NULL,
  `monto_mora` decimal(10,2) NOT NULL DEFAULT 0,
  `monto_total` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `fecha_generacion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `dias_mora` int NOT NULL DEFAULT 0,
  `prioridad` int NOT NULL DEFAULT 5,
  `fk_id_plan_pagos` bigint,
  `bloqueado_servicios` boolean NOT NULL DEFAULT false,
  `requiere_atencion` boolean DEFAULT false,
  `fecha_ultimo_pago` timestamp,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_modificacion` timestamp,
  `fk_id_usuario_creacion` bigint,
  `fk_id_usuario_modificacion` bigint
);

CREATE TABLE `PLAN_PAGOS` (
  `id_plan_pagos` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_plan` varchar(50) UNIQUE NOT NULL,
  `fk_id_deuda` bigint NOT NULL,
  `fk_id_usuario` bigint NOT NULL,
  `numero_cuotas` int NOT NULL,
  `monto_cuota` decimal(10,2) NOT NULL,
  `monto_inicial` decimal(10,2) DEFAULT 0,
  `monto_total_plan` decimal(10,2) NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `fecha_primera_cuota` date NOT NULL,
  `fecha_ultima_cuota` date NOT NULL,
  `periodicidad` varchar(20) NOT NULL,
  `cuotas_pagadas` int NOT NULL DEFAULT 0,
  `cuotas_pendientes` int NOT NULL,
  `monto_pagado` decimal(10,2) NOT NULL DEFAULT 0,
  `monto_pendiente` decimal(10,2) NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'SOLICITADO',
  `fecha_aprobacion` timestamp,
  `fk_id_usuario_aprueba` bigint,
  `fecha_cancelacion` timestamp,
  `motivo_cancelacion` text,
  `condiciones` text,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CUOTA_PLAN_PAGOS` (
  `id_cuota` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_plan_pagos` bigint NOT NULL,
  `numero_cuota` int NOT NULL,
  `monto_cuota` decimal(10,2) NOT NULL,
  `monto_mora` decimal(10,2) NOT NULL DEFAULT 0,
  `monto_total` decimal(10,2) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `dias_mora` int NOT NULL DEFAULT 0,
  `monto_pagado` decimal(10,2) NOT NULL DEFAULT 0,
  `monto_pendiente` decimal(10,2) NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_pago` timestamp,
  `observaciones` text
);

CREATE TABLE `APLICACION_PAGO_DEUDA` (
  `id_aplicacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_pago` bigint,
  `fk_id_deuda` bigint,
  `fk_id_cuota` bigint,
  `monto_aplicado` decimal(10,2) NOT NULL,
  `monto_a_capital` decimal(10,2) NOT NULL,
  `monto_a_mora` decimal(10,2) NOT NULL DEFAULT 0,
  `fecha_aplicacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `tipo_aplicacion` varchar(30) NOT NULL,
  `numero_operacion` varchar(100),
  `observaciones` text,
  `fk_id_usuario_aplica` bigint
);

CREATE TABLE `SERVICIO_BLOQUEADO` (
  `id_servicio_bloqueado` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre_servicio` varchar(150) NOT NULL,
  `descripcion` text,
  `modulo` varchar(50) NOT NULL,
  `criticidad` varchar(20) NOT NULL,
  `orden_bloqueo` int DEFAULT 5,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `BLOQUEO_SERVICIO` (
  `id_bloqueo` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_deuda` bigint NOT NULL,
  `fk_id_servicio_bloqueado` int NOT NULL,
  `fecha_bloqueo` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_desbloqueo` timestamp,
  `activo` boolean NOT NULL DEFAULT true,
  `motivo` text NOT NULL,
  `motivo_desbloqueo` text,
  `fk_id_usuario_bloquea` bigint,
  `fk_id_usuario_desbloquea` bigint,
  `observaciones` text
);

CREATE TABLE `HISTORIAL_DEUDA` (
  `id_historial` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_deuda` bigint NOT NULL,
  `estado_anterior` varchar(30),
  `estado_nuevo` varchar(30) NOT NULL,
  `monto_anterior` decimal(10,2),
  `monto_nuevo` decimal(10,2) NOT NULL,
  `monto_mora_anterior` decimal(10,2),
  `monto_mora_nuevo` decimal(10,2),
  `tipo_cambio` varchar(50) NOT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_cambio` bigint,
  `ip_origen` varchar(45),
  `comentario` text,
  `datos_adicionales_json` text
);

CREATE TABLE `ALERTA_DEUDA` (
  `id_alerta` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_deuda` bigint NOT NULL,
  `tipo_alerta` varchar(50) NOT NULL,
  `nivel` varchar(20) NOT NULL,
  `asunto` varchar(200) NOT NULL,
  `mensaje` text NOT NULL,
  `canal` varchar(30) NOT NULL,
  `destinatario` varchar(200) NOT NULL,
  `fecha_programada` timestamp NOT NULL,
  `fecha_envio` timestamp,
  `enviado` boolean NOT NULL DEFAULT false,
  `fecha_lectura` timestamp,
  `intentos_envio` int NOT NULL DEFAULT 0,
  `estado_entrega` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `respuesta_canal` text,
  `observaciones` text
);

CREATE TABLE `CONDONACION_DEUDA` (
  `id_condonacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_condonacion` varchar(50) UNIQUE NOT NULL,
  `fk_id_deuda` bigint NOT NULL,
  `monto_original_deuda` decimal(10,2) NOT NULL,
  `monto_condonado` decimal(10,2) NOT NULL,
  `porcentaje_condonacion` decimal(5,2) NOT NULL,
  `monto_a_pagar` decimal(10,2) NOT NULL,
  `tipo_condonacion` varchar(50) NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `justificacion` text NOT NULL,
  `documentos_sustento` text,
  `fecha_solicitud` date NOT NULL,
  `fecha_aprobacion` date,
  `fecha_rechazo` date,
  `fk_id_usuario_solicita` bigint,
  `fk_id_usuario_aprueba` bigint,
  `fk_id_expediente` bigint,
  `numero_resolucion` varchar(100),
  `fecha_resolucion` date,
  `estado` varchar(30) NOT NULL DEFAULT 'SOLICITADO',
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `GARANTIA` (
  `id_garantia` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_plan_pagos` bigint NOT NULL,
  `tipo_garantia` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `valor_garantia` decimal(10,2),
  `documento_garantia` text,
  `fecha_constitucion` date NOT NULL,
  `fecha_vencimiento` date,
  `fk_id_garante` bigint,
  `datos_garante_json` text,
  `vigente` boolean NOT NULL DEFAULT true,
  `fecha_liberacion` date,
  `motivo_liberacion` text,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CONVENIO_PAGO` (
  `id_convenio` bigint PRIMARY KEY AUTO_INCREMENT,
  `numero_convenio` varchar(50) UNIQUE NOT NULL,
  `fk_id_plan_pagos` bigint NOT NULL,
  `fk_id_deuda` bigint NOT NULL,
  `fk_id_usuario` bigint NOT NULL,
  `fecha_convenio` date NOT NULL,
  `fecha_vencimiento_convenio` date NOT NULL,
  `terminos` text NOT NULL,
  `clausulas` text,
  `penalidades` text,
  `estado` varchar(30) NOT NULL DEFAULT 'VIGENTE',
  `documento_url` varchar(500),
  `hash_documento` varchar(255),
  `fecha_firma` timestamp,
  `fk_id_usuario_universidad` bigint,
  `testigos` text,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `TIPO_COMPROBANTE` (
  `id_tipo_comprobante` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(20) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `requiere_ruc` boolean DEFAULT false,
  `requiere_validacion_sunat` boolean DEFAULT false,
  `afecta_igv` boolean DEFAULT true,
  `activo` boolean DEFAULT true
);

CREATE TABLE `ORDEN_COMPRA` (
  `id_orden_compra` bigint PRIMARY KEY AUTO_INCREMENT,
  `numero_orden` varchar(50) UNIQUE NOT NULL,
  `fk_id_proveedor` bigint NOT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_entrega_programada` date,
  `monto_total` decimal(12,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `estado` varchar(30) NOT NULL,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `ORDEN_SERVICIO` (
  `id_orden_servicio` bigint PRIMARY KEY AUTO_INCREMENT,
  `numero_orden` varchar(50) UNIQUE NOT NULL,
  `fk_id_proveedor` bigint NOT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_inicio_servicio` date,
  `fecha_fin_servicio` date,
  `monto_total` decimal(12,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `estado` varchar(30) NOT NULL,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `FACTURA` (
  `id_factura` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_proveedor` bigint NOT NULL,
  `fk_id_tipo_comprobante` int NOT NULL,
  `fk_id_orden_compra` bigint,
  `fk_id_orden_servicio` bigint,
  `serie` varchar(10) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `numero_completo` varchar(30) UNIQUE NOT NULL,
  `ruc_emisor` varchar(11) NOT NULL,
  `razon_social_emisor` varchar(300) NOT NULL,
  `fecha_emision` date NOT NULL,
  `fecha_vencimiento` date,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `subtotal` decimal(12,2) NOT NULL,
  `igv_porcentaje` decimal(5,2) DEFAULT 18,
  `igv_monto` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `descripcion_servicio` text,
  `glosa` text,
  `xml_sunat` text,
  `cdr_sunat` text,
  `hash_sunat` varchar(255),
  `estado_sunat` varchar(50),
  `validado_sunat` boolean DEFAULT false,
  `fecha_validacion_sunat` timestamp,
  `estado_procesamiento` varchar(30) NOT NULL DEFAULT 'REGISTRADO',
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_registro` bigint
);

CREATE TABLE `DETALLE_FACTURA` (
  `id_detalle_factura` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_factura` bigint NOT NULL,
  `numero_item` int NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `unidad_medida` varchar(20),
  `cantidad` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL
);

CREATE TABLE `CONFORMIDAD` (
  `id_conformidad` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_conformidad` varchar(50) UNIQUE NOT NULL,
  `fk_id_factura` bigint NOT NULL,
  `fk_id_orden_compra` bigint,
  `fk_id_orden_servicio` bigint,
  `fecha_conformidad` date NOT NULL,
  `conforme` boolean NOT NULL,
  `observaciones` text,
  `documento_conformidad_url` varchar(500),
  `fk_id_usuario_responsable` bigint,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `DEVENGADO` (
  `id_devengado` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_devengado` varchar(50) UNIQUE NOT NULL,
  `fk_id_factura` bigint NOT NULL,
  `fk_id_conformidad` bigint NOT NULL,
  `monto_total` decimal(12,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `fecha_devengado` date NOT NULL,
  `glosa` text NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'REGISTRADO',
  `secuencia_siaf` varchar(50),
  `fecha_registro_siaf` timestamp,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_registro` bigint
);

CREATE TABLE `DETALLE_DEVENGADO` (
  `id_detalle_devengado` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_devengado` bigint NOT NULL,
  `fk_id_clasificador_gasto` varchar(20),
  `fk_id_fuente_financiamiento` int,
  `fk_id_meta_presupuestal` int,
  `monto` decimal(12,2) NOT NULL,
  `porcentaje` decimal(5,2),
  `glosa` varchar(500)
);

CREATE TABLE `ORDEN_PAGO_EGRESO` (
  `id_orden_pago_egreso` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_orden` varchar(50) UNIQUE NOT NULL,
  `fk_id_devengado` bigint,
  `fk_id_proveedor` bigint,
  `monto_bruto` decimal(12,2) NOT NULL,
  `monto_retenciones` decimal(12,2) DEFAULT 0,
  `monto_neto` decimal(12,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `fecha_emision` date NOT NULL,
  `fecha_programada` date NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `secuencia_siaf` varchar(50),
  `fecha_registro_siaf` timestamp,
  `fecha_autorizacion` timestamp,
  `fk_id_usuario_autoriza` bigint,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_registro` bigint
);

CREATE TABLE `CUENTA_BANCARIA_PROVEEDOR` (
  `id_cuenta_bancaria_proveedor` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_proveedor` bigint NOT NULL,
  `fk_id_banco` int NOT NULL,
  `numero_cuenta` varchar(50) NOT NULL,
  `numero_cuenta_interbancaria` varchar(20),
  `tipo_cuenta` varchar(30) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `principal` boolean DEFAULT false,
  `activo` boolean DEFAULT true,
  `fecha_validacion` date,
  `documento_validacion_url` varchar(500),
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `PAGO_PROVEEDOR` (
  `id_pago_proveedor` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_pago` varchar(50) UNIQUE NOT NULL,
  `fk_id_orden_pago_egreso` bigint NOT NULL,
  `fk_id_cuenta_bancaria_proveedor` bigint NOT NULL,
  `fk_id_cuenta_bancaria_universidad` int,
  `monto_bruto` decimal(12,2) NOT NULL,
  `monto_retenciones` decimal(12,2) DEFAULT 0,
  `monto_neto` decimal(12,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `fecha_programada` date NOT NULL,
  `fecha_pago` timestamp,
  `numero_operacion_banco` varchar(100),
  `estado` varchar(30) NOT NULL DEFAULT 'PROGRAMADO',
  `fk_id_movimiento_bancario` bigint,
  `respuesta_banco` text,
  `codigo_transaccion_banco` varchar(100),
  `fecha_conciliacion` timestamp,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_ejecuta` bigint
);

CREATE TABLE `RETENCION` (
  `id_retencion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_pago_proveedor` bigint NOT NULL,
  `tipo_retencion` varchar(50) NOT NULL,
  `base_calculo` decimal(12,2) NOT NULL,
  `porcentaje` decimal(5,2) NOT NULL,
  `monto_retencion` decimal(12,2) NOT NULL,
  `concepto` varchar(200) NOT NULL,
  `codigo_sunat` varchar(10),
  `estado` varchar(30) NOT NULL DEFAULT 'APLICADO',
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CAJA_CHICA` (
  `id_caja_chica` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `fk_id_area` int NOT NULL,
  `monto_asignado` decimal(10,2) NOT NULL,
  `saldo_disponible` decimal(10,2) NOT NULL,
  `saldo_comprometido` decimal(10,2) DEFAULT 0,
  `estado` varchar(30) NOT NULL DEFAULT 'ACTIVO',
  `fecha_apertura` date NOT NULL,
  `fecha_cierre` date,
  `anio_fiscal` int NOT NULL,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `RESPONSABLE_CAJA_CHICA` (
  `id_responsable` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_caja_chica` int NOT NULL,
  `fk_id_usuario` bigint NOT NULL,
  `fecha_designacion` date NOT NULL,
  `fecha_cese` date,
  `activo` boolean NOT NULL DEFAULT true,
  `acta_compromiso_url` varchar(500),
  `monto_garantia` decimal(10,2),
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `TIPO_GASTO_CAJA_CHICA` (
  `id_tipo_gasto` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text,
  `monto_maximo` decimal(10,2),
  `requiere_autorizacion_especial` boolean DEFAULT false,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `SOLICITUD_GASTO` (
  `id_solicitud` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_solicitud` varchar(50) UNIQUE NOT NULL,
  `fk_id_caja_chica` int NOT NULL,
  `fk_id_usuario_solicitante` bigint NOT NULL,
  `fk_id_tipo_gasto` int NOT NULL,
  `descripcion_gasto` text NOT NULL,
  `justificacion` text NOT NULL,
  `monto_solicitado` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `fecha_solicitud` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_requerida` date,
  `estado` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `observaciones` text
);

CREATE TABLE `APROBACION_SOLICITUD` (
  `id_aprobacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_solicitud` bigint NOT NULL,
  `fk_id_usuario_aprobador` bigint NOT NULL,
  `fecha_aprobacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `aprobado` boolean NOT NULL,
  `monto_aprobado` decimal(10,2),
  `observaciones` text
);

CREATE TABLE `ENTREGA_EFECTIVO` (
  `id_entrega` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_solicitud` bigint NOT NULL,
  `monto_entregado` decimal(10,2) NOT NULL,
  `fecha_entrega` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_entrega` bigint NOT NULL,
  `recibo_numero` varchar(50),
  `recibo_firma_url` varchar(500),
  `observaciones` text
);

CREATE TABLE `COMPROBANTE_GASTO` (
  `id_comprobante` bigint PRIMARY KEY AUTO_INCREMENT,
  `tipo_comprobante` varchar(30) NOT NULL,
  `serie` varchar(10),
  `numero` varchar(20),
  `numero_completo` varchar(30),
  `ruc_emisor` varchar(11),
  `razon_social_emisor` varchar(300),
  `fecha_emision` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `validado_sunat` boolean DEFAULT false,
  `documento_url` varchar(500),
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `RENDICION_GASTO` (
  `id_rendicion` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_rendicion` varchar(50) UNIQUE NOT NULL,
  `fk_id_solicitud` bigint NOT NULL,
  `fk_id_comprobante` bigint NOT NULL,
  `monto_gastado` decimal(10,2) NOT NULL,
  `vuelto` decimal(10,2) DEFAULT 0,
  `fecha_rendicion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `estado` varchar(30) NOT NULL DEFAULT 'RENDIDO',
  `observaciones` text,
  `fecha_aprobacion_rendicion` timestamp,
  `fk_id_usuario_aprueba_rendicion` bigint
);

CREATE TABLE `DETALLE_RENDICION` (
  `id_detalle_rendicion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_rendicion` bigint NOT NULL,
  `fk_id_clasificador_gasto` varchar(20) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `descripcion` text
);

CREATE TABLE `REEMBOLSO_CAJA_CHICA` (
  `id_reembolso` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_reembolso` varchar(50) UNIQUE NOT NULL,
  `fk_id_caja_chica` int NOT NULL,
  `monto_reembolso` decimal(10,2) NOT NULL,
  `fecha_solicitud` date NOT NULL,
  `fecha_aprobacion` date,
  `fecha_transferencia` date,
  `numero_operacion` varchar(100),
  `estado` varchar(30) NOT NULL DEFAULT 'SOLICITADO',
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_solicita` bigint
);

CREATE TABLE `RENDICION_REEMBOLSO` (
  `id_rendicion_reembolso` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_reembolso` bigint NOT NULL,
  `fk_id_rendicion` bigint NOT NULL
);

CREATE TABLE `ARQUEO_CAJA_CHICA` (
  `id_arqueo` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_arqueo` varchar(50) UNIQUE NOT NULL,
  `fk_id_caja_chica` int NOT NULL,
  `fecha_arqueo` date NOT NULL,
  `hora_arqueo` time NOT NULL,
  `saldo_sistema` decimal(10,2) NOT NULL,
  `saldo_fisico` decimal(10,2) NOT NULL,
  `diferencia` decimal(10,2) NOT NULL,
  `tipo_arqueo` varchar(30) NOT NULL,
  `resultado` varchar(30) NOT NULL,
  `acta_arqueo_url` varchar(500),
  `observaciones` text,
  `fk_id_usuario_arquea` bigint NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CAJA_DIARIA` (
  `id_caja_diaria` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(200) NOT NULL,
  `tipo_caja` varchar(30) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'ACTIVO',
  `monto_fondo_fijo` decimal(10,2) DEFAULT 0,
  `permite_efectivo` boolean DEFAULT true,
  `permite_pos` boolean DEFAULT true,
  `permite_transferencias` boolean DEFAULT false,
  `fecha_apertura` date NOT NULL,
  `fecha_cierre` date,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `CAJERO` (
  `id_cajero` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint NOT NULL,
  `fk_id_caja_diaria` int NOT NULL,
  `fecha_asignacion` date NOT NULL,
  `fecha_cese` date,
  `activo` boolean DEFAULT true,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `TURNO_CAJA` (
  `id_turno_caja` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_caja_diaria` int NOT NULL,
  `fk_id_cajero` bigint NOT NULL,
  `tipo_turno` varchar(20) NOT NULL,
  `fecha_turno` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time,
  `estado` varchar(20) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `APERTURA_CAJA` (
  `id_apertura_caja` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_turno_caja` bigint NOT NULL,
  `monto_inicial_efectivo` decimal(10,2) NOT NULL DEFAULT 0,
  `monto_inicial_pos` decimal(10,2) NOT NULL DEFAULT 0,
  `fecha_hora_apertura` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `observaciones` text
);

CREATE TABLE `CIERRE_CAJA` (
  `id_cierre_caja` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_turno_caja` bigint NOT NULL,
  `monto_esperado_efectivo` decimal(10,2) NOT NULL,
  `monto_contado_efectivo` decimal(10,2) NOT NULL,
  `diferencia_efectivo` decimal(10,2) NOT NULL,
  `monto_esperado_pos` decimal(10,2) NOT NULL,
  `monto_contado_pos` decimal(10,2) NOT NULL,
  `diferencia_pos` decimal(10,2) NOT NULL,
  `total_ingresos` decimal(10,2) NOT NULL,
  `total_egresos` decimal(10,2) NOT NULL,
  `numero_transacciones` int NOT NULL,
  `fecha_hora_cierre` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `estado_cierre` varchar(30) NOT NULL,
  `observaciones` text,
  `acta_cierre_url` varchar(500)
);

CREATE TABLE `MOVIMIENTO_CAJA` (
  `id_movimiento_caja` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_turno_caja` bigint NOT NULL,
  `fk_id_pago` bigint,
  `tipo_movimiento` varchar(30) NOT NULL,
  `tipo_operacion` varchar(30) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `medio_pago` varchar(30) NOT NULL,
  `fecha_hora_movimiento` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `numero_operacion` varchar(100),
  `descripcion` varchar(500),
  `observaciones` text
);

CREATE TABLE `ARQUEO_CAJA_DIARIA` (
  `id_arqueo_caja_diaria` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_arqueo` varchar(50) UNIQUE NOT NULL,
  `fk_id_turno_caja` bigint NOT NULL,
  `fecha_arqueo` date NOT NULL,
  `hora_arqueo` time NOT NULL,
  `saldo_sistema_efectivo` decimal(10,2) NOT NULL,
  `saldo_fisico_efectivo` decimal(10,2) NOT NULL,
  `diferencia_efectivo` decimal(10,2) NOT NULL,
  `saldo_sistema_pos` decimal(10,2) NOT NULL,
  `saldo_fisico_pos` decimal(10,2) NOT NULL,
  `diferencia_pos` decimal(10,2) NOT NULL,
  `tipo_arqueo` varchar(30) NOT NULL,
  `resultado` varchar(30) NOT NULL,
  `acta_arqueo_url` varchar(500),
  `observaciones` text,
  `fk_id_usuario_arquea` bigint NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `DEPOSITO_BANCARIO` (
  `id_deposito_bancario` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_deposito` varchar(50) UNIQUE NOT NULL,
  `fk_id_caja_diaria` int NOT NULL,
  `fk_id_cuenta_bancaria_universidad` int NOT NULL,
  `monto_deposito` decimal(10,2) NOT NULL,
  `fecha_deposito` date NOT NULL,
  `numero_operacion` varchar(100),
  `boleta_deposito_url` varchar(500),
  `estado` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_conciliacion` timestamp,
  `fk_id_movimiento_bancario` bigint,
  `observaciones` text,
  `fk_id_usuario_deposita` bigint NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `DIFERENCIA_CAJA` (
  `id_diferencia_caja` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_cierre_caja` bigint,
  `fk_id_arqueo_caja_diaria` bigint,
  `tipo_diferencia` varchar(30) NOT NULL,
  `monto_diferencia` decimal(10,2) NOT NULL,
  `origen` varchar(30) NOT NULL,
  `justificacion` text,
  `estado_justificacion` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `fk_id_usuario_justifica` bigint,
  `fecha_justificacion` timestamp,
  `fk_id_usuario_aprueba` bigint,
  `fecha_aprobacion` timestamp,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `BANCO` (
  `id_banco` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(20) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `nombre_corto` varchar(50),
  `swift_code` varchar(11),
  `pais` varchar(3) NOT NULL DEFAULT 'PER',
  `activo` boolean DEFAULT true,
  `requiere_formato_especial` boolean DEFAULT false,
  `formato_archivo` varchar(50),
  `url_api` varchar(300),
  `tipo_integracion` varchar(30) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CUENTA_BANCARIA_UNIVERSIDAD` (
  `id_cuenta_bancaria` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_banco` int NOT NULL,
  `numero_cuenta` varchar(50) NOT NULL,
  `numero_cuenta_interbancaria` varchar(20),
  `tipo_cuenta` varchar(30) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `saldo_actual` decimal(15,2) DEFAULT 0,
  `fecha_apertura` date NOT NULL,
  `fecha_cierre` date,
  `proposito` varchar(100) NOT NULL,
  `fk_id_fuente_financiamiento` int,
  `activo` boolean DEFAULT true,
  `permite_ingresos` boolean DEFAULT true,
  `permite_egresos` boolean DEFAULT true,
  `requiere_autorizacion_especial` boolean DEFAULT false,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `MOVIMIENTO_BANCARIO` (
  `id_movimiento_bancario` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_cuenta_bancaria` int NOT NULL,
  `tipo_movimiento` varchar(50) NOT NULL,
  `fecha_movimiento` date NOT NULL,
  `fecha_valor` date NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `moneda` varchar(3) NOT NULL DEFAULT 'PEN',
  `numero_operacion` varchar(100) NOT NULL,
  `referencia` varchar(300),
  `documento_origen` varchar(50),
  `documento_destino` varchar(50),
  `nombre_origen` varchar(300),
  `nombre_destino` varchar(300),
  `banco_origen` varchar(100),
  `banco_destino` varchar(100),
  `concepto` text,
  `codigo_transaccion_banco` varchar(100),
  `saldo_despues_movimiento` decimal(15,2),
  `estado` varchar(30) NOT NULL DEFAULT 'REGISTRADO',
  `conciliado` boolean DEFAULT false,
  `fecha_conciliacion` timestamp,
  `fk_id_pago` bigint,
  `fk_id_pago_proveedor` bigint,
  `origen_registro` varchar(30) NOT NULL,
  `canal` varchar(50),
  `observaciones` text,
  `fecha_registro` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_registro` bigint
);

CREATE TABLE `TIPO_MOVIMIENTO_BANCARIO` (
  `id_tipo_movimiento` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `categoria` varchar(30) NOT NULL,
  `signo` varchar(1) NOT NULL,
  `descripcion` text,
  `requiere_documento` boolean DEFAULT false,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `ARCHIVO_BANCO` (
  `id_archivo_banco` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_cuenta_bancaria` int NOT NULL,
  `nombre_archivo` varchar(300) NOT NULL,
  `ruta_archivo` varchar(500) NOT NULL,
  `tipo_archivo` varchar(50) NOT NULL,
  `formato` varchar(30) NOT NULL,
  `fecha_archivo` date NOT NULL,
  `fecha_subida` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `tamanio_bytes` bigint NOT NULL,
  `hash_archivo` varchar(64) NOT NULL,
  `total_registros` int DEFAULT 0,
  `registros_procesados` int DEFAULT 0,
  `registros_error` int DEFAULT 0,
  `estado_procesamiento` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_inicio_procesamiento` timestamp,
  `fecha_fin_procesamiento` timestamp,
  `log_procesamiento` text,
  `fk_id_usuario_subida` bigint NOT NULL
);

CREATE TABLE `CONCILIACION_BANCARIA` (
  `id_conciliacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_cuenta_bancaria` int NOT NULL,
  `periodo` varchar(7) NOT NULL,
  `fecha_conciliacion` date NOT NULL,
  `fecha_inicio_periodo` date NOT NULL,
  `fecha_fin_periodo` date NOT NULL,
  `saldo_inicial_banco` decimal(15,2) NOT NULL,
  `saldo_final_banco` decimal(15,2) NOT NULL,
  `saldo_inicial_sistema` decimal(15,2) NOT NULL,
  `saldo_final_sistema` decimal(15,2) NOT NULL,
  `total_abonos_banco` decimal(15,2) DEFAULT 0,
  `total_cargos_banco` decimal(15,2) DEFAULT 0,
  `total_abonos_sistema` decimal(15,2) DEFAULT 0,
  `total_cargos_sistema` decimal(15,2) DEFAULT 0,
  `diferencia` decimal(15,2) NOT NULL,
  `total_movimientos_conciliados` int DEFAULT 0,
  `total_movimientos_pendientes` int DEFAULT 0,
  `estado` varchar(30) NOT NULL DEFAULT 'EN_PROCESO',
  `tipo_conciliacion` varchar(30) NOT NULL,
  `automatica` boolean DEFAULT false,
  `observaciones` text,
  `fecha_aprobacion` timestamp,
  `fk_id_usuario_concilia` bigint NOT NULL,
  `fk_id_usuario_aprueba` bigint,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `DETALLE_CONCILIACION` (
  `id_detalle_conciliacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_conciliacion` bigint NOT NULL,
  `fk_id_movimiento_bancario` bigint,
  `fk_id_pago` bigint,
  `fk_id_pago_proveedor` bigint,
  `tipo_detalle` varchar(30) NOT NULL,
  `monto` decimal(12,2) NOT NULL,
  `fecha_movimiento` date NOT NULL,
  `numero_operacion` varchar(100),
  `estado_detalle` varchar(30) NOT NULL,
  `score_matching` decimal(5,2) DEFAULT 0,
  `conciliado_automaticamente` boolean DEFAULT false,
  `observaciones` text,
  `fecha_matching` timestamp
);

CREATE TABLE `ERROR_CONCILIACION` (
  `id_error` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_conciliacion` bigint NOT NULL,
  `fk_id_movimiento_bancario` bigint,
  `tipo_error` varchar(50) NOT NULL,
  `descripcion_error` text NOT NULL,
  `monto_afectado` decimal(12,2),
  `fecha_deteccion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `estado_resolucion` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_resolucion` timestamp,
  `accion_correctiva` text,
  `fk_id_usuario_resuelve` bigint
);

CREATE TABLE `FUENTE_FINANCIAMIENTO` (
  `id_fuente_financiamiento` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(10) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rubro` varchar(10) NOT NULL,
  `descripcion` text,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CLASIFICADOR_INGRESO` (
  `id_clasificador_ingreso` varchar(20) PRIMARY KEY,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text,
  `activo` boolean DEFAULT true,
  `anio_fiscal` int NOT NULL
);

CREATE TABLE `CLASIFICADOR_GASTO` (
  `id_clasificador_gasto` varchar(20) PRIMARY KEY,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text,
  `activo` boolean DEFAULT true,
  `anio_fiscal` int NOT NULL
);

CREATE TABLE `META_PRESUPUESTAL` (
  `id_meta_presupuestal` int PRIMARY KEY AUTO_INCREMENT,
  `anio_fiscal` int NOT NULL,
  `codigo_meta` varchar(10) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `fk_id_fuente_financiamiento` int NOT NULL,
  `presupuesto_inicial` decimal(14,2) NOT NULL,
  `presupuesto_modificado` decimal(14,2) NOT NULL,
  `presupuesto_comprometido` decimal(14,2) DEFAULT 0,
  `presupuesto_devengado` decimal(14,2) DEFAULT 0,
  `presupuesto_girado` decimal(14,2) DEFAULT 0,
  `saldo_disponible` decimal(14,2) NOT NULL,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `CERTIFICACION_PRESUPUESTAL` (
  `id_certificacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `numero_certificacion` varchar(20) NOT NULL,
  `anio_fiscal` int NOT NULL,
  `fecha_certificacion` date NOT NULL,
  `fk_id_meta_presupuestal` int NOT NULL,
  `fk_id_clasificador_gasto` varchar(20) NOT NULL,
  `monto_certificado` decimal(12,2) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'VIGENTE',
  `fk_id_expediente` bigint,
  `fecha_vencimiento` date,
  `observaciones` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `NOTA_CONTABLE_SIAF` (
  `id_nota_contable` bigint PRIMARY KEY AUTO_INCREMENT,
  `numero_nota` varchar(20) NOT NULL,
  `anio_fiscal` int NOT NULL,
  `tipo_nota` varchar(10) NOT NULL,
  `fecha_nota` date NOT NULL,
  `fk_id_devengado` bigint,
  `fk_id_pago` bigint,
  `glosa` text NOT NULL,
  `monto_total` decimal(12,2) NOT NULL,
  `estado_envio` varchar(20) NOT NULL DEFAULT 'PENDIENTE',
  `codigo_respuesta_siaf` varchar(10),
  `mensaje_respuesta_siaf` text,
  `fecha_envio` timestamp,
  `fecha_respuesta` timestamp,
  `intentos_envio` int DEFAULT 0
);

CREATE TABLE `DETALLE_NOTA_CONTABLE` (
  `id_detalle_nota` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_nota_contable` bigint NOT NULL,
  `fk_id_clasificador_gasto` varchar(20),
  `fk_id_fuente_financiamiento` int,
  `fk_id_meta_presupuestal` int,
  `debe` decimal(12,2) DEFAULT 0,
  `haber` decimal(12,2) DEFAULT 0,
  `glosa` varchar(500)
);

CREATE TABLE `LOG_INTEGRACION_SIAF` (
  `id_log_siaf` bigint PRIMARY KEY AUTO_INCREMENT,
  `tipo_operacion` varchar(50) NOT NULL,
  `tabla_afectada` varchar(50),
  `id_registro_afectado` bigint,
  `trama_envio` text,
  `trama_respuesta` text,
  `estado_respuesta` varchar(20),
  `codigo_error` varchar(20),
  `mensaje_error` text,
  `tiempo_procesamiento_ms` int,
  `fecha_evento` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `EJECUCION_PRESUPUESTAL` (
  `id_ejecucion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_meta_presupuestal` int NOT NULL,
  `fk_id_clasificador_gasto` varchar(20) NOT NULL,
  `mes` int NOT NULL,
  `anio` int NOT NULL,
  `pia` decimal(12,2) NOT NULL,
  `pim` decimal(12,2) NOT NULL,
  `certificado` decimal(12,2) DEFAULT 0,
  `comprometido_anual` decimal(12,2) DEFAULT 0,
  `comprometido_mensual` decimal(12,2) DEFAULT 0,
  `devengado` decimal(12,2) DEFAULT 0,
  `girado` decimal(12,2) DEFAULT 0,
  `saldo` decimal(12,2) NOT NULL,
  `avance_porcentual` decimal(5,2) DEFAULT 0,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `EXPEDIENTE` (
  `id_expediente` bigint PRIMARY KEY AUTO_INCREMENT,
  `codigo_expediente` varchar(50) UNIQUE NOT NULL,
  `tipo_expediente` varchar(50) NOT NULL,
  `asunto` varchar(200) NOT NULL,
  `fk_id_usuario_solicitante` bigint NOT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_fin` timestamp,
  `estado` varchar(30) NOT NULL DEFAULT 'INICIADO',
  `prioridad` varchar(20) DEFAULT 'MEDIA',
  `datos_formulario_json` text,
  `fecha_limite` date,
  `observaciones` text
);

CREATE TABLE `PROCESO_WORKFLOW` (
  `id_proceso` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `version` int NOT NULL DEFAULT 1,
  `definicion_bpmn_xml` text,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `INSTANCIA_WORKFLOW` (
  `id_instancia` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_expediente` bigint NOT NULL,
  `fk_id_proceso` int NOT NULL,
  `etapa_actual` varchar(100) NOT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_fin` timestamp,
  `estado` varchar(30) NOT NULL DEFAULT 'EN_PROGRESO',
  `datos_contexto_json` text
);

CREATE TABLE `TAREA` (
  `id_tarea` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_instancia` bigint NOT NULL,
  `nombre_tarea` varchar(100) NOT NULL,
  `descripcion` text,
  `fk_id_rol_asignado` int,
  `fk_id_usuario_asignado` bigint,
  `fecha_asignacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_vencimiento` timestamp,
  `fecha_completado` timestamp,
  `estado` varchar(30) NOT NULL DEFAULT 'PENDIENTE',
  `accion_tomada` varchar(50),
  `comentarios` text,
  `prioridad` varchar(20) DEFAULT 'MEDIA'
);

CREATE TABLE `SLA_WORKFLOW` (
  `id_sla` int PRIMARY KEY AUTO_INCREMENT,
  `fk_id_proceso` int NOT NULL,
  `nombre_tarea` varchar(100) NOT NULL,
  `tiempo_maximo_horas` int NOT NULL,
  `accion_vencimiento` varchar(50),
  `notificar_antes_horas` int DEFAULT 24,
  `escalamiento_automatico` boolean DEFAULT false,
  `fk_id_rol_escalamiento` int
);

CREATE TABLE `HISTORIAL_TAREA` (
  `id_historial_tarea` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_tarea` bigint NOT NULL,
  `accion` varchar(50) NOT NULL,
  `estado_anterior` varchar(30),
  `estado_nuevo` varchar(30) NOT NULL,
  `fk_id_usuario_accion` bigint NOT NULL,
  `comentario` text,
  `datos_adicionales_json` text,
  `fecha_accion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `LOG_AUDITORIA` (
  `id_audit` bigint PRIMARY KEY AUTO_INCREMENT,
  `tabla_afectada` varchar(50) NOT NULL,
  `id_registro_afectado` varchar(50) NOT NULL,
  `accion` varchar(20) NOT NULL,
  `valor_anterior_json` text,
  `valor_nuevo_json` text,
  `fk_id_usuario` bigint NOT NULL,
  `ip_origen` varchar(45),
  `user_agent` varchar(200),
  `fecha_evento` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `hash_registro` varchar(255) NOT NULL,
  `hash_anterior` varchar(255)
);

CREATE TABLE `LOG_ACCESO` (
  `id_log_acceso` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario` bigint NOT NULL,
  `tipo_evento` varchar(20) NOT NULL,
  `ip_origen` varchar(45),
  `dispositivo` varchar(100),
  `navegador` varchar(100),
  `ubicacion_estimada` varchar(100),
  `fecha_evento` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `exitoso` boolean DEFAULT true,
  `mensaje_error` varchar(200)
);

CREATE TABLE `DOCUMENTO` (
  `id_documento` bigint PRIMARY KEY AUTO_INCREMENT,
  `nombre_original` varchar(200) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `tamanio_bytes` bigint NOT NULL,
  `ruta_almacenamiento` varchar(500) NOT NULL,
  `hash_contenido` varchar(255) NOT NULL,
  `categoria_documento` varchar(50),
  `fk_id_usuario_subida` bigint NOT NULL,
  `fecha_subida` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `estado` varchar(20) DEFAULT 'ACTIVO',
  `nivel_confidencialidad` varchar(20) DEFAULT 'PUBLICO'
);

CREATE TABLE `VERSION_DOCUMENTO` (
  `id_version` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_documento` bigint NOT NULL,
  `numero_version` int NOT NULL,
  `ruta_almacenamiento` varchar(500) NOT NULL,
  `hash_contenido` varchar(255) NOT NULL,
  `tamanio_bytes` bigint NOT NULL,
  `fk_id_usuario_cambio` bigint NOT NULL,
  `fecha_cambio` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `comentario_cambio` text
);

CREATE TABLE `INDICADOR_KPI` (
  `id_kpi` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `categoria` varchar(50) NOT NULL,
  `formula_calculo` text,
  `frecuencia_calculo` varchar(20),
  `meta_objetivo` decimal(10,2),
  `unidad_medida` varchar(20),
  `tipo_grafico` varchar(30),
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `VALOR_INDICADOR` (
  `id_valor_kpi` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_kpi` int NOT NULL,
  `fecha_calculo` date NOT NULL,
  `periodo` varchar(10) NOT NULL,
  `valor_medido` decimal(14,4) NOT NULL,
  `cumple_meta` boolean,
  `observaciones` text,
  `fecha_registro` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `NOTIFICACION` (
  `id_notificacion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_usuario_destinatario` bigint NOT NULL,
  `tipo_notificacion` varchar(50) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `mensaje` text NOT NULL,
  `prioridad` varchar(20) DEFAULT 'MEDIA',
  `canal` varchar(30) NOT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'PENDIENTE',
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_envio` timestamp,
  `fecha_lectura` timestamp,
  `leida` boolean DEFAULT false,
  `url_accion` varchar(500),
  `datos_adicionales_json` text
);

CREATE TABLE `CONFIGURACION_SISTEMA` (
  `id_configuracion` int PRIMARY KEY AUTO_INCREMENT,
  `clave` varchar(100) UNIQUE NOT NULL,
  `valor` text NOT NULL,
  `tipo_dato` varchar(20) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `descripcion` text,
  `editable` boolean DEFAULT true,
  `fecha_modificacion` timestamp,
  `fk_id_usuario_modificacion` bigint
);

CREATE TABLE `PARAMETRO_SISTEMA` (
  `id_parametro` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `valor_texto` varchar(500),
  `valor_numerico` decimal(12,2),
  `valor_fecha` date,
  `valor_booleano` boolean,
  `tipo_parametro` varchar(30) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `descripcion` text,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_modificacion` timestamp,
  `fk_id_usuario_modificacion` bigint
);

CREATE TABLE `FACULTAD` (
  `id_facultad` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(20) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `decano` varchar(150),
  `email` varchar(100),
  `telefono` varchar(15),
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `ESCUELA` (
  `id_escuela` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(20) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `fk_id_facultad` int NOT NULL,
  `director` varchar(150),
  `email` varchar(100),
  `telefono` varchar(15),
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `DEPARTAMENTO_ACADEMICO` (
  `id_departamento` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(20) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `fk_id_facultad` int NOT NULL,
  `jefe` varchar(150),
  `email` varchar(100),
  `telefono` varchar(15),
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `AREA_ADMINISTRATIVA` (
  `id_area` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(20) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `fk_id_area_padre` int,
  `jefe` varchar(150),
  `email` varchar(100),
  `telefono` varchar(15),
  `nivel_jerarquico` int DEFAULT 1,
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE `UBIGEO` (
  `codigo_ubigeo` varchar(6) PRIMARY KEY,
  `departamento` varchar(50) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  `distrito` varchar(50) NOT NULL
);

CREATE TABLE `REPORTE` (
  `id_reporte` int PRIMARY KEY AUTO_INCREMENT,
  `codigo` varchar(50) UNIQUE NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text,
  `categoria` varchar(50) NOT NULL,
  `tipo_reporte` varchar(30) NOT NULL,
  `query_sql` text,
  `parametros_json` text,
  `formato_salida` varchar(20) NOT NULL,
  `frecuencia_generacion` varchar(20),
  `activo` boolean DEFAULT true,
  `fecha_creacion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fk_id_usuario_creacion` bigint
);

CREATE TABLE `EJECUCION_REPORTE` (
  `id_ejecucion` bigint PRIMARY KEY AUTO_INCREMENT,
  `fk_id_reporte` int NOT NULL,
  `fk_id_usuario_ejecuta` bigint NOT NULL,
  `parametros_usados_json` text,
  `fecha_ejecucion` timestamp NOT NULL DEFAULT (CURRENT_TIMESTAMP),
  `fecha_finalizacion` timestamp,
  `estado` varchar(20) NOT NULL DEFAULT 'EN_PROCESO',
  `ruta_archivo_generado` varchar(500),
  `tiempo_ejecucion_ms` int,
  `numero_registros` int,
  `mensaje_error` text
);

CREATE UNIQUE INDEX `uk_usuario_documento` ON `USUARIO` (`numero_documento`);

CREATE UNIQUE INDEX `uk_usuario_email_inst` ON `USUARIO` (`email_institucional`);

CREATE INDEX `idx_usuario_estado_tipo` ON `USUARIO` (`estado`, `tipo_documento`);

CREATE UNIQUE INDEX `uk_estudiante_codigo` ON `ESTUDIANTE` (`codigo_estudiante`);

CREATE UNIQUE INDEX `uk_estudiante_usuario` ON `ESTUDIANTE` (`fk_id_usuario`);

CREATE INDEX `idx_estudiante_situacion` ON `ESTUDIANTE` (`situacion_academica`, `estado`);

CREATE INDEX `idx_estudiante_facultad_escuela` ON `ESTUDIANTE` (`fk_id_facultad`, `fk_id_escuela`);

CREATE UNIQUE INDEX `uk_docente_codigo` ON `DOCENTE` (`codigo_docente`);

CREATE UNIQUE INDEX `uk_docente_usuario` ON `DOCENTE` (`fk_id_usuario`);

CREATE INDEX `idx_docente_categoria` ON `DOCENTE` (`categoria`, `estado`);

CREATE INDEX `idx_docente_departamento` ON `DOCENTE` (`fk_id_departamento`);

CREATE UNIQUE INDEX `uk_personal_codigo` ON `PERSONAL_ADMINISTRATIVO` (`codigo_trabajador`);

CREATE UNIQUE INDEX `uk_personal_usuario` ON `PERSONAL_ADMINISTRATIVO` (`fk_id_usuario`);

CREATE INDEX `idx_personal_area` ON `PERSONAL_ADMINISTRATIVO` (`fk_id_area`);

CREATE UNIQUE INDEX `uk_proveedor_ruc` ON `PROVEEDOR` (`ruc`);

CREATE INDEX `idx_proveedor_tipo` ON `PROVEEDOR` (`tipo_proveedor`, `activo`);

CREATE INDEX `idx_proveedor_estado_sunat` ON `PROVEEDOR` (`estado_sunat`);

CREATE UNIQUE INDEX `uk_rol_codigo` ON `ROL` (`codigo`);

CREATE INDEX `idx_rol_activo` ON `ROL` (`activo`);

CREATE INDEX `idx_usuario_rol_activo` ON `USUARIO_ROL` (`fk_id_usuario`, `fk_id_rol`, `estado`);

CREATE INDEX `idx_usuario_rol_vigencia` ON `USUARIO_ROL` (`fecha_vigencia_inicio`, `fecha_vigencia_fin`);

CREATE UNIQUE INDEX `uk_permiso_codigo` ON `PERMISO` (`codigo`);

CREATE INDEX `idx_permiso_modulo_accion` ON `PERMISO` (`modulo`, `accion`);

CREATE UNIQUE INDEX `uk_rol_permiso` ON `ROL_PERMISO` (`fk_id_rol`, `fk_id_permiso`);

CREATE UNIQUE INDEX `uk_sesion_token` ON `SESION` (`token_sesion`);

CREATE INDEX `idx_sesion_usuario_estado` ON `SESION` (`fk_id_usuario`, `estado`);

CREATE INDEX `idx_sesion_fecha` ON `SESION` (`fecha_inicio`);

CREATE UNIQUE INDEX `uk_reniec_dni` ON `PERSONA_NATURAL_RENIEC` (`dni`);

CREATE INDEX `idx_reniec_fecha` ON `PERSONA_NATURAL_RENIEC` (`fecha_consulta`);

CREATE UNIQUE INDEX `uk_sunat_ruc` ON `PERSONA_JURIDICA_SUNAT` (`ruc`);

CREATE INDEX `idx_sunat_estado` ON `PERSONA_JURIDICA_SUNAT` (`estado`, `condicion`);

CREATE INDEX `idx_sunat_fecha` ON `PERSONA_JURIDICA_SUNAT` (`fecha_consulta`);

CREATE UNIQUE INDEX `uk_categoria_codigo` ON `CATEGORIA_CONCEPTO` (`codigo`);

CREATE UNIQUE INDEX `uk_concepto_codigo` ON `CONCEPTO_INGRESO` (`codigo`);

CREATE INDEX `idx_concepto_categoria` ON `CONCEPTO_INGRESO` (`fk_id_categoria_concepto`, `activo`);

CREATE INDEX `idx_concepto_clasificador` ON `CONCEPTO_INGRESO` (`clasificador_siaf`);

CREATE UNIQUE INDEX `uk_periodo_codigo` ON `PERIODO_ACADEMICO` (`codigo`);

CREATE INDEX `idx_periodo_anio` ON `PERIODO_ACADEMICO` (`anio`, `numero_periodo`);

CREATE INDEX `idx_periodo_fechas` ON `PERIODO_ACADEMICO` (`fecha_inicio`, `fecha_fin`);

CREATE UNIQUE INDEX `uk_tipo_beneficiario_codigo` ON `TIPO_BENEFICIARIO` (`codigo`);

CREATE UNIQUE INDEX `uk_descuento_codigo` ON `DESCUENTO` (`codigo`);

CREATE INDEX `idx_descuento_vigencia` ON `DESCUENTO` (`fecha_vigencia_inicio`, `fecha_vigencia_fin`);

CREATE UNIQUE INDEX `uk_tupa_codigo` ON `TUPA` (`codigo_procedimiento`);

CREATE INDEX `idx_tupa_anio` ON `TUPA` (`anio_vigencia`, `activo`);

CREATE INDEX `idx_tupa_concepto` ON `TUPA` (`fk_id_concepto_ingreso`);

CREATE INDEX `idx_actualizacion_tupa_tarifario` ON `ACTUALIZACION_TARIFARIO` (`fk_id_tupa`, `fk_id_tarifario`);

CREATE INDEX `idx_actualizacion_fecha` ON `ACTUALIZACION_TARIFARIO` (`fecha_actualizacion`);

CREATE INDEX `idx_actualizacion_tipo` ON `ACTUALIZACION_TARIFARIO` (`tipo_actualizacion`);

CREATE INDEX `idx_tarifario_concepto_anio` ON `TARIFARIO` (`fk_id_concepto_ingreso`, `anio`, `fk_id_tipo_beneficiario`);

CREATE INDEX `idx_tarifario_vigencia` ON `TARIFARIO` (`fecha_vigencia_inicio`, `fecha_vigencia_fin`);

CREATE INDEX `idx_tarifario_activo` ON `TARIFARIO` (`activo`);

CREATE UNIQUE INDEX `uk_orden_codigo` ON `ORDEN_PAGO_INGRESO` (`codigo_orden`);

CREATE INDEX `idx_orden_usuario_estado` ON `ORDEN_PAGO_INGRESO` (`fk_id_usuario`, `estado`);

CREATE INDEX `idx_orden_vencimiento` ON `ORDEN_PAGO_INGRESO` (`fecha_vencimiento`, `estado`);

CREATE INDEX `idx_orden_concepto_fecha` ON `ORDEN_PAGO_INGRESO` (`fk_id_concepto_ingreso`, `fecha_emision`);

CREATE INDEX `idx_detalle_orden_item` ON `DETALLE_ORDEN_PAGO` (`fk_id_orden_pago_ingreso`, `numero_item`);

CREATE UNIQUE INDEX `uk_medio_pago_codigo` ON `MEDIO_PAGO` (`codigo`);

CREATE INDEX `idx_medio_pago_tipo` ON `MEDIO_PAGO` (`tipo_medio`, `activo`);

CREATE UNIQUE INDEX `uk_pago_codigo` ON `PAGO` (`codigo_pago`);

CREATE INDEX `idx_pago_orden` ON `PAGO` (`fk_id_orden_pago_ingreso`);

CREATE INDEX `idx_pago_fecha_estado` ON `PAGO` (`fecha_pago`, `estado`);

CREATE INDEX `idx_pago_operacion` ON `PAGO` (`numero_operacion`);

CREATE INDEX `idx_pago_movimiento` ON `PAGO` (`fk_id_movimiento_bancario`);

CREATE INDEX `idx_detalle_pago_clasi` ON `DETALLE_PAGO_CLASIFICADOR` (`fk_id_pago`, `fk_id_clasificador_ingreso`);

CREATE UNIQUE INDEX `uk_recibo_codigo` ON `RECIBO_PAGO` (`codigo_recibo`);

CREATE UNIQUE INDEX `uk_recibo_numero` ON `RECIBO_PAGO` (`numero_completo`);

CREATE INDEX `idx_recibo_pago` ON `RECIBO_PAGO` (`fk_id_pago`);

CREATE INDEX `idx_recibo_fecha` ON `RECIBO_PAGO` (`fecha_emision`, `estado`);

CREATE UNIQUE INDEX `uk_tipo_deuda_codigo` ON `TIPO_DEUDA` (`codigo`);

CREATE INDEX `idx_tipo_deuda_prioridad` ON `TIPO_DEUDA` (`prioridad_cobro`);

CREATE UNIQUE INDEX `uk_estado_deuda_codigo` ON `ESTADO_DEUDA` (`codigo`);

CREATE UNIQUE INDEX `uk_deuda_codigo` ON `DEUDA` (`codigo_deuda`);

CREATE INDEX `idx_deuda_usuario_estado` ON `DEUDA` (`fk_id_usuario`, `fk_id_estado_deuda`);

CREATE INDEX `idx_deuda_vencimiento` ON `DEUDA` (`fecha_vencimiento`, `fk_id_estado_deuda`);

CREATE INDEX `idx_deuda_mora` ON `DEUDA` (`dias_mora`);

CREATE INDEX `idx_deuda_prioridad` ON `DEUDA` (`prioridad`, `fecha_generacion`);

CREATE INDEX `idx_deuda_bloqueado` ON `DEUDA` (`bloqueado_servicios`);

CREATE UNIQUE INDEX `uk_plan_codigo` ON `PLAN_PAGOS` (`codigo_plan`);

CREATE INDEX `idx_plan_deuda` ON `PLAN_PAGOS` (`fk_id_deuda`);

CREATE INDEX `idx_plan_usuario_estado` ON `PLAN_PAGOS` (`fk_id_usuario`, `estado`);

CREATE INDEX `idx_plan_fecha_cuota` ON `PLAN_PAGOS` (`fecha_primera_cuota`);

CREATE UNIQUE INDEX `uk_cuota_plan_numero` ON `CUOTA_PLAN_PAGOS` (`fk_id_plan_pagos`, `numero_cuota`);

CREATE INDEX `idx_cuota_vencimiento` ON `CUOTA_PLAN_PAGOS` (`fecha_vencimiento`, `estado`);

CREATE INDEX `idx_cuota_estado` ON `CUOTA_PLAN_PAGOS` (`estado`);

CREATE INDEX `idx_aplicacion_pago` ON `APLICACION_PAGO_DEUDA` (`fk_id_pago`);

CREATE INDEX `idx_aplicacion_deuda` ON `APLICACION_PAGO_DEUDA` (`fk_id_deuda`);

CREATE INDEX `idx_aplicacion_cuota` ON `APLICACION_PAGO_DEUDA` (`fk_id_cuota`);

CREATE INDEX `idx_aplicacion_fecha` ON `APLICACION_PAGO_DEUDA` (`fecha_aplicacion`);

CREATE UNIQUE INDEX `uk_servicio_codigo` ON `SERVICIO_BLOQUEADO` (`codigo`);

CREATE INDEX `idx_servicio_modulo` ON `SERVICIO_BLOQUEADO` (`modulo`, `criticidad`);

CREATE INDEX `idx_servicio_orden` ON `SERVICIO_BLOQUEADO` (`orden_bloqueo`);

CREATE INDEX `idx_bloqueo_deuda_servicio` ON `BLOQUEO_SERVICIO` (`fk_id_deuda`, `fk_id_servicio_bloqueado`, `activo`);

CREATE INDEX `idx_bloqueo_activo` ON `BLOQUEO_SERVICIO` (`activo`);

CREATE INDEX `idx_bloqueo_fecha` ON `BLOQUEO_SERVICIO` (`fecha_bloqueo`);

CREATE INDEX `idx_historial_deuda_fecha` ON `HISTORIAL_DEUDA` (`fk_id_deuda`, `fecha_cambio`);

CREATE INDEX `idx_historial_tipo` ON `HISTORIAL_DEUDA` (`tipo_cambio`);

CREATE INDEX `idx_alerta_deuda_tipo` ON `ALERTA_DEUDA` (`fk_id_deuda`, `tipo_alerta`);

CREATE INDEX `idx_alerta_programada` ON `ALERTA_DEUDA` (`fecha_programada`, `enviado`);

CREATE INDEX `idx_alerta_nivel` ON `ALERTA_DEUDA` (`nivel`, `estado_entrega`);

CREATE UNIQUE INDEX `uk_condonacion_codigo` ON `CONDONACION_DEUDA` (`codigo_condonacion`);

CREATE INDEX `idx_condonacion_deuda` ON `CONDONACION_DEUDA` (`fk_id_deuda`);

CREATE INDEX `idx_condonacion_estado` ON `CONDONACION_DEUDA` (`estado`, `fecha_solicitud`);

CREATE INDEX `idx_condonacion_resolucion` ON `CONDONACION_DEUDA` (`numero_resolucion`);

CREATE INDEX `idx_garantia_plan` ON `GARANTIA` (`fk_id_plan_pagos`);

CREATE INDEX `idx_garantia_vigente` ON `GARANTIA` (`vigente`);

CREATE UNIQUE INDEX `uk_convenio_numero` ON `CONVENIO_PAGO` (`numero_convenio`);

CREATE INDEX `idx_convenio_plan` ON `CONVENIO_PAGO` (`fk_id_plan_pagos`);

CREATE INDEX `idx_convenio_deuda` ON `CONVENIO_PAGO` (`fk_id_deuda`);

CREATE INDEX `idx_convenio_estado` ON `CONVENIO_PAGO` (`estado`, `fecha_convenio`);

CREATE UNIQUE INDEX `uk_tipo_comprobante_codigo` ON `TIPO_COMPROBANTE` (`codigo`);

CREATE UNIQUE INDEX `uk_orden_compra_numero` ON `ORDEN_COMPRA` (`numero_orden`);

CREATE INDEX `idx_oc_proveedor` ON `ORDEN_COMPRA` (`fk_id_proveedor`, `estado`);

CREATE UNIQUE INDEX `uk_orden_servicio_numero` ON `ORDEN_SERVICIO` (`numero_orden`);

CREATE INDEX `idx_os_proveedor` ON `ORDEN_SERVICIO` (`fk_id_proveedor`, `estado`);

CREATE UNIQUE INDEX `uk_factura_numero` ON `FACTURA` (`numero_completo`);

CREATE INDEX `idx_factura_ruc` ON `FACTURA` (`ruc_emisor`, `serie`, `numero`);

CREATE INDEX `idx_factura_proveedor` ON `FACTURA` (`fk_id_proveedor`, `fecha_emision`);

CREATE INDEX `idx_factura_estado` ON `FACTURA` (`estado_procesamiento`);

CREATE INDEX `idx_factura_fecha` ON `FACTURA` (`fecha_emision`);

CREATE INDEX `idx_detalle_factura_item` ON `DETALLE_FACTURA` (`fk_id_factura`, `numero_item`);

CREATE UNIQUE INDEX `uk_conformidad_codigo` ON `CONFORMIDAD` (`codigo_conformidad`);

CREATE INDEX `idx_conformidad_factura` ON `CONFORMIDAD` (`fk_id_factura`);

CREATE UNIQUE INDEX `uk_devengado_codigo` ON `DEVENGADO` (`codigo_devengado`);

CREATE UNIQUE INDEX `uk_devengado_factura` ON `DEVENGADO` (`fk_id_factura`);

CREATE INDEX `idx_devengado_siaf` ON `DEVENGADO` (`secuencia_siaf`);

CREATE INDEX `idx_devengado_fecha` ON `DEVENGADO` (`fecha_devengado`, `estado`);

CREATE INDEX `idx_detalle_devengado_clasi` ON `DETALLE_DEVENGADO` (`fk_id_devengado`, `fk_id_clasificador_gasto`);

CREATE UNIQUE INDEX `uk_orden_egreso_codigo` ON `ORDEN_PAGO_EGRESO` (`codigo_orden`);

CREATE UNIQUE INDEX `uk_orden_egreso_devengado` ON `ORDEN_PAGO_EGRESO` (`fk_id_devengado`);

CREATE INDEX `idx_orden_egreso_proveedor` ON `ORDEN_PAGO_EGRESO` (`fk_id_proveedor`, `estado`);

CREATE INDEX `idx_orden_egreso_fecha` ON `ORDEN_PAGO_EGRESO` (`fecha_programada`, `estado`);

CREATE INDEX `idx_orden_egreso_siaf` ON `ORDEN_PAGO_EGRESO` (`secuencia_siaf`);

CREATE UNIQUE INDEX `uk_cuenta_proveedor` ON `CUENTA_BANCARIA_PROVEEDOR` (`fk_id_proveedor`, `numero_cuenta`);

CREATE INDEX `idx_cuenta_principal` ON `CUENTA_BANCARIA_PROVEEDOR` (`fk_id_proveedor`, `principal`);

CREATE UNIQUE INDEX `uk_pago_proveedor_codigo` ON `PAGO_PROVEEDOR` (`codigo_pago`);

CREATE INDEX `idx_pago_prov_orden` ON `PAGO_PROVEEDOR` (`fk_id_orden_pago_egreso`);

CREATE INDEX `idx_pago_prov_operacion` ON `PAGO_PROVEEDOR` (`numero_operacion_banco`);

CREATE INDEX `idx_pago_prov_fecha` ON `PAGO_PROVEEDOR` (`fecha_pago`, `estado`);

CREATE INDEX `idx_pago_prov_movimiento` ON `PAGO_PROVEEDOR` (`fk_id_movimiento_bancario`);

CREATE INDEX `idx_retencion_pago_tipo` ON `RETENCION` (`fk_id_pago_proveedor`, `tipo_retencion`);

CREATE INDEX `idx_retencion_tipo_estado` ON `RETENCION` (`tipo_retencion`, `estado`);

CREATE UNIQUE INDEX `uk_caja_chica_codigo` ON `CAJA_CHICA` (`codigo`);

CREATE INDEX `idx_caja_area_anio` ON `CAJA_CHICA` (`fk_id_area`, `anio_fiscal`);

CREATE INDEX `idx_caja_estado` ON `CAJA_CHICA` (`estado`);

CREATE INDEX `idx_responsable_caja_activo` ON `RESPONSABLE_CAJA_CHICA` (`fk_id_caja_chica`, `activo`);

CREATE INDEX `idx_responsable_usuario_activo` ON `RESPONSABLE_CAJA_CHICA` (`fk_id_usuario`, `activo`);

CREATE UNIQUE INDEX `uk_tipo_gasto_codigo` ON `TIPO_GASTO_CAJA_CHICA` (`codigo`);

CREATE INDEX `idx_tipo_gasto_activo` ON `TIPO_GASTO_CAJA_CHICA` (`activo`);

CREATE UNIQUE INDEX `uk_solicitud_codigo` ON `SOLICITUD_GASTO` (`codigo_solicitud`);

CREATE INDEX `idx_solicitud_caja_estado` ON `SOLICITUD_GASTO` (`fk_id_caja_chica`, `estado`);

CREATE INDEX `idx_solicitud_usuario` ON `SOLICITUD_GASTO` (`fk_id_usuario_solicitante`, `fecha_solicitud`);

CREATE INDEX `idx_solicitud_estado_fecha` ON `SOLICITUD_GASTO` (`estado`, `fecha_solicitud`);

CREATE UNIQUE INDEX `uk_aprobacion_solicitud` ON `APROBACION_SOLICITUD` (`fk_id_solicitud`);

CREATE INDEX `idx_aprobacion_usuario` ON `APROBACION_SOLICITUD` (`fk_id_usuario_aprobador`, `fecha_aprobacion`);

CREATE UNIQUE INDEX `uk_entrega_solicitud` ON `ENTREGA_EFECTIVO` (`fk_id_solicitud`);

CREATE INDEX `idx_entrega_fecha` ON `ENTREGA_EFECTIVO` (`fecha_entrega`);

CREATE INDEX `idx_entrega_recibo` ON `ENTREGA_EFECTIVO` (`recibo_numero`);

CREATE INDEX `idx_comprobante_numero` ON `COMPROBANTE_GASTO` (`numero_completo`);

CREATE INDEX `idx_comprobante_ruc` ON `COMPROBANTE_GASTO` (`ruc_emisor`, `fecha_emision`);

CREATE INDEX `idx_comprobante_fecha` ON `COMPROBANTE_GASTO` (`fecha_emision`);

CREATE UNIQUE INDEX `uk_rendicion_codigo` ON `RENDICION_GASTO` (`codigo_rendicion`);

CREATE UNIQUE INDEX `uk_rendicion_solicitud` ON `RENDICION_GASTO` (`fk_id_solicitud`);

CREATE INDEX `idx_rendicion_estado` ON `RENDICION_GASTO` (`estado`);

CREATE INDEX `idx_rendicion_fecha` ON `RENDICION_GASTO` (`fecha_rendicion`);

CREATE INDEX `idx_detalle_rendicion` ON `DETALLE_RENDICION` (`fk_id_rendicion`);

CREATE INDEX `idx_detalle_rendicion_clasificador` ON `DETALLE_RENDICION` (`fk_id_clasificador_gasto`);

CREATE UNIQUE INDEX `uk_reembolso_codigo` ON `REEMBOLSO_CAJA_CHICA` (`codigo_reembolso`);

CREATE INDEX `idx_reembolso_caja` ON `REEMBOLSO_CAJA_CHICA` (`fk_id_caja_chica`, `estado`);

CREATE INDEX `idx_reembolso_fecha` ON `REEMBOLSO_CAJA_CHICA` (`fecha_solicitud`);

CREATE INDEX `idx_reembolso_estado` ON `REEMBOLSO_CAJA_CHICA` (`estado`);

CREATE UNIQUE INDEX `uk_rendicion_reembolso` ON `RENDICION_REEMBOLSO` (`fk_id_reembolso`, `fk_id_rendicion`);

CREATE UNIQUE INDEX `uk_arqueo_codigo` ON `ARQUEO_CAJA_CHICA` (`codigo_arqueo`);

CREATE INDEX `idx_arqueo_caja_fecha` ON `ARQUEO_CAJA_CHICA` (`fk_id_caja_chica`, `fecha_arqueo`);

CREATE INDEX `idx_arqueo_resultado` ON `ARQUEO_CAJA_CHICA` (`resultado`);

CREATE INDEX `idx_arqueo_tipo` ON `ARQUEO_CAJA_CHICA` (`tipo_arqueo`);

CREATE UNIQUE INDEX `uk_caja_diaria_codigo` ON `CAJA_DIARIA` (`codigo`);

CREATE INDEX `idx_caja_diaria_estado` ON `CAJA_DIARIA` (`estado`, `activo`);

CREATE INDEX `idx_caja_diaria_tipo` ON `CAJA_DIARIA` (`tipo_caja`);

CREATE INDEX `idx_cajero_usuario_caja` ON `CAJERO` (`fk_id_usuario`, `fk_id_caja_diaria`, `activo`);

CREATE INDEX `idx_cajero_activo` ON `CAJERO` (`activo`);

CREATE INDEX `idx_turno_caja_fecha` ON `TURNO_CAJA` (`fk_id_caja_diaria`, `fecha_turno`, `tipo_turno`);

CREATE INDEX `idx_turno_cajero` ON `TURNO_CAJA` (`fk_id_cajero`, `fecha_turno`);

CREATE INDEX `idx_turno_estado` ON `TURNO_CAJA` (`estado`);

CREATE UNIQUE INDEX `uk_apertura_turno` ON `APERTURA_CAJA` (`fk_id_turno_caja`);

CREATE INDEX `idx_apertura_fecha` ON `APERTURA_CAJA` (`fecha_hora_apertura`);

CREATE UNIQUE INDEX `uk_cierre_turno` ON `CIERRE_CAJA` (`fk_id_turno_caja`);

CREATE INDEX `idx_cierre_fecha` ON `CIERRE_CAJA` (`fecha_hora_cierre`);

CREATE INDEX `idx_cierre_estado` ON `CIERRE_CAJA` (`estado_cierre`);

CREATE INDEX `idx_movimiento_turno_fecha` ON `MOVIMIENTO_CAJA` (`fk_id_turno_caja`, `fecha_hora_movimiento`);

CREATE INDEX `idx_movimiento_pago` ON `MOVIMIENTO_CAJA` (`fk_id_pago`);

CREATE INDEX `idx_movimiento_tipo` ON `MOVIMIENTO_CAJA` (`tipo_movimiento`, `tipo_operacion`);

CREATE UNIQUE INDEX `uk_arqueo_caja_codigo` ON `ARQUEO_CAJA_DIARIA` (`codigo_arqueo`);

CREATE INDEX `idx_arqueo_turno_fecha` ON `ARQUEO_CAJA_DIARIA` (`fk_id_turno_caja`, `fecha_arqueo`);

CREATE INDEX `idx_arqueo_resultado` ON `ARQUEO_CAJA_DIARIA` (`resultado`);

CREATE INDEX `idx_arqueo_tipo` ON `ARQUEO_CAJA_DIARIA` (`tipo_arqueo`);

CREATE UNIQUE INDEX `uk_deposito_codigo` ON `DEPOSITO_BANCARIO` (`codigo_deposito`);

CREATE INDEX `idx_deposito_caja_fecha` ON `DEPOSITO_BANCARIO` (`fk_id_caja_diaria`, `fecha_deposito`);

CREATE INDEX `idx_deposito_operacion` ON `DEPOSITO_BANCARIO` (`numero_operacion`);

CREATE INDEX `idx_deposito_estado` ON `DEPOSITO_BANCARIO` (`estado`);

CREATE INDEX `idx_diferencia_cierre` ON `DIFERENCIA_CAJA` (`fk_id_cierre_caja`);

CREATE INDEX `idx_diferencia_arqueo` ON `DIFERENCIA_CAJA` (`fk_id_arqueo_caja_diaria`);

CREATE INDEX `idx_diferencia_estado` ON `DIFERENCIA_CAJA` (`estado_justificacion`);

CREATE INDEX `idx_diferencia_tipo` ON `DIFERENCIA_CAJA` (`tipo_diferencia`);

CREATE UNIQUE INDEX `uk_banco_codigo` ON `BANCO` (`codigo`);

CREATE INDEX `idx_banco_activo` ON `BANCO` (`activo`);

CREATE UNIQUE INDEX `uk_cuenta_banco_numero` ON `CUENTA_BANCARIA_UNIVERSIDAD` (`fk_id_banco`, `numero_cuenta`);

CREATE UNIQUE INDEX `uk_cuenta_cci` ON `CUENTA_BANCARIA_UNIVERSIDAD` (`numero_cuenta_interbancaria`);

CREATE INDEX `idx_cuenta_activa_tipo` ON `CUENTA_BANCARIA_UNIVERSIDAD` (`activo`, `tipo_cuenta`);

CREATE INDEX `idx_movimiento_cuenta_fecha` ON `MOVIMIENTO_BANCARIO` (`fk_id_cuenta_bancaria`, `fecha_movimiento`);

CREATE INDEX `idx_movimiento_operacion` ON `MOVIMIENTO_BANCARIO` (`numero_operacion`);

CREATE INDEX `idx_movimiento_conciliado` ON `MOVIMIENTO_BANCARIO` (`conciliado`, `estado`);

CREATE INDEX `idx_movimiento_fecha_valor` ON `MOVIMIENTO_BANCARIO` (`fecha_valor`);

CREATE INDEX `idx_movimiento_tipo` ON `MOVIMIENTO_BANCARIO` (`tipo_movimiento`);

CREATE UNIQUE INDEX `uk_tipo_mov_codigo` ON `TIPO_MOVIMIENTO_BANCARIO` (`codigo`);

CREATE INDEX `idx_tipo_mov_categoria` ON `TIPO_MOVIMIENTO_BANCARIO` (`categoria`, `activo`);

CREATE INDEX `idx_archivo_cuenta_fecha` ON `ARCHIVO_BANCO` (`fk_id_cuenta_bancaria`, `fecha_archivo`);

CREATE UNIQUE INDEX `uk_archivo_hash` ON `ARCHIVO_BANCO` (`hash_archivo`);

CREATE INDEX `idx_archivo_estado` ON `ARCHIVO_BANCO` (`estado_procesamiento`);

CREATE INDEX `idx_archivo_tipo` ON `ARCHIVO_BANCO` (`tipo_archivo`);

CREATE UNIQUE INDEX `uk_conciliacion_cuenta_periodo` ON `CONCILIACION_BANCARIA` (`fk_id_cuenta_bancaria`, `periodo`);

CREATE INDEX `idx_conciliacion_fecha_estado` ON `CONCILIACION_BANCARIA` (`fecha_conciliacion`, `estado`);

CREATE INDEX `idx_conciliacion_estado` ON `CONCILIACION_BANCARIA` (`estado`);

CREATE INDEX `idx_detalle_conciliacion_tipo` ON `DETALLE_CONCILIACION` (`fk_id_conciliacion`, `tipo_detalle`);

CREATE INDEX `idx_detalle_movimiento` ON `DETALLE_CONCILIACION` (`fk_id_movimiento_bancario`);

CREATE INDEX `idx_detalle_estado` ON `DETALLE_CONCILIACION` (`estado_detalle`);

CREATE INDEX `idx_error_conciliacion_tipo` ON `ERROR_CONCILIACION` (`fk_id_conciliacion`, `tipo_error`);

CREATE INDEX `idx_error_estado` ON `ERROR_CONCILIACION` (`estado_resolucion`);

CREATE UNIQUE INDEX `uk_fuente_codigo` ON `FUENTE_FINANCIAMIENTO` (`codigo`);

CREATE INDEX `idx_fuente_activo` ON `FUENTE_FINANCIAMIENTO` (`activo`);

CREATE INDEX `idx_clasi_ingreso_anio` ON `CLASIFICADOR_INGRESO` (`anio_fiscal`, `activo`);

CREATE INDEX `idx_clasi_gasto_anio` ON `CLASIFICADOR_GASTO` (`anio_fiscal`, `activo`);

CREATE UNIQUE INDEX `uk_meta_anio_codigo` ON `META_PRESUPUESTAL` (`anio_fiscal`, `codigo_meta`);

CREATE INDEX `idx_meta_activo` ON `META_PRESUPUESTAL` (`activo`);

CREATE UNIQUE INDEX `uk_certificacion_numero` ON `CERTIFICACION_PRESUPUESTAL` (`numero_certificacion`, `anio_fiscal`);

CREATE INDEX `idx_certificacion_estado` ON `CERTIFICACION_PRESUPUESTAL` (`estado`);

CREATE INDEX `idx_certificacion_meta` ON `CERTIFICACION_PRESUPUESTAL` (`fk_id_meta_presupuestal`);

CREATE UNIQUE INDEX `uk_nota_numero` ON `NOTA_CONTABLE_SIAF` (`numero_nota`, `anio_fiscal`);

CREATE INDEX `idx_nota_estado` ON `NOTA_CONTABLE_SIAF` (`estado_envio`);

CREATE INDEX `idx_nota_fecha` ON `NOTA_CONTABLE_SIAF` (`fecha_nota`);

CREATE INDEX `idx_detalle_nota` ON `DETALLE_NOTA_CONTABLE` (`fk_id_nota_contable`);

CREATE INDEX `idx_log_siaf_fecha` ON `LOG_INTEGRACION_SIAF` (`fecha_evento`);

CREATE INDEX `idx_log_siaf_tipo` ON `LOG_INTEGRACION_SIAF` (`tipo_operacion`);

CREATE INDEX `idx_log_siaf_estado` ON `LOG_INTEGRACION_SIAF` (`estado_respuesta`);

CREATE UNIQUE INDEX `uk_ejecucion_meta_periodo` ON `EJECUCION_PRESUPUESTAL` (`fk_id_meta_presupuestal`, `anio`, `mes`);

CREATE INDEX `idx_ejecucion_periodo` ON `EJECUCION_PRESUPUESTAL` (`anio`, `mes`);

CREATE UNIQUE INDEX `uk_expediente_codigo` ON `EXPEDIENTE` (`codigo_expediente`);

CREATE INDEX `idx_expediente_estado` ON `EXPEDIENTE` (`estado`);

CREATE INDEX `idx_expediente_usuario` ON `EXPEDIENTE` (`fk_id_usuario_solicitante`);

CREATE INDEX `idx_expediente_tipo_estado` ON `EXPEDIENTE` (`tipo_expediente`, `estado`);

CREATE UNIQUE INDEX `uk_proceso_version` ON `PROCESO_WORKFLOW` (`codigo`, `version`);

CREATE INDEX `idx_proceso_activo` ON `PROCESO_WORKFLOW` (`activo`);

CREATE INDEX `idx_instancia_expediente` ON `INSTANCIA_WORKFLOW` (`fk_id_expediente`);

CREATE INDEX `idx_instancia_estado` ON `INSTANCIA_WORKFLOW` (`estado`);

CREATE INDEX `idx_tarea_usuario` ON `TAREA` (`fk_id_usuario_asignado`, `estado`);

CREATE INDEX `idx_tarea_rol` ON `TAREA` (`fk_id_rol_asignado`, `estado`);

CREATE INDEX `idx_tarea_vencimiento` ON `TAREA` (`fecha_vencimiento`, `estado`);

CREATE UNIQUE INDEX `uk_sla_proceso_tarea` ON `SLA_WORKFLOW` (`fk_id_proceso`, `nombre_tarea`);

CREATE INDEX `idx_historial_tarea_fecha` ON `HISTORIAL_TAREA` (`fk_id_tarea`, `fecha_accion`);

CREATE INDEX `idx_audit_registro` ON `LOG_AUDITORIA` (`tabla_afectada`, `id_registro_afectado`);

CREATE INDEX `idx_audit_fecha` ON `LOG_AUDITORIA` (`fecha_evento`);

CREATE INDEX `idx_audit_usuario` ON `LOG_AUDITORIA` (`fk_id_usuario`);

CREATE INDEX `idx_audit_accion` ON `LOG_AUDITORIA` (`accion`);

CREATE INDEX `idx_acceso_usuario` ON `LOG_ACCESO` (`fk_id_usuario`, `fecha_evento`);

CREATE INDEX `idx_acceso_tipo` ON `LOG_ACCESO` (`tipo_evento`, `exitoso`);

CREATE INDEX `idx_acceso_fecha` ON `LOG_ACCESO` (`fecha_evento`);

CREATE INDEX `idx_documento_hash` ON `DOCUMENTO` (`hash_contenido`);

CREATE INDEX `idx_documento_categoria` ON `DOCUMENTO` (`categoria_documento`);

CREATE INDEX `idx_documento_estado` ON `DOCUMENTO` (`estado`);

CREATE UNIQUE INDEX `uk_version_documento` ON `VERSION_DOCUMENTO` (`fk_id_documento`, `numero_version`);

CREATE INDEX `idx_version_fecha` ON `VERSION_DOCUMENTO` (`fecha_cambio`);

CREATE UNIQUE INDEX `uk_kpi_codigo` ON `INDICADOR_KPI` (`codigo`);

CREATE INDEX `idx_kpi_categoria` ON `INDICADOR_KPI` (`categoria`, `activo`);

CREATE UNIQUE INDEX `uk_valor_kpi_fecha` ON `VALOR_INDICADOR` (`fk_id_kpi`, `fecha_calculo`);

CREATE INDEX `idx_valor_periodo` ON `VALOR_INDICADOR` (`periodo`);

CREATE INDEX `idx_notif_usuario_leida` ON `NOTIFICACION` (`fk_id_usuario_destinatario`, `leida`);

CREATE INDEX `idx_notif_estado` ON `NOTIFICACION` (`estado`);

CREATE INDEX `idx_notif_fecha` ON `NOTIFICACION` (`fecha_creacion`);

CREATE UNIQUE INDEX `uk_config_clave` ON `CONFIGURACION_SISTEMA` (`clave`);

CREATE INDEX `idx_config_categoria` ON `CONFIGURACION_SISTEMA` (`categoria`);

CREATE UNIQUE INDEX `uk_parametro_codigo` ON `PARAMETRO_SISTEMA` (`codigo`);

CREATE INDEX `idx_parametro_categoria` ON `PARAMETRO_SISTEMA` (`categoria`, `activo`);

CREATE UNIQUE INDEX `uk_facultad_codigo` ON `FACULTAD` (`codigo`);

CREATE INDEX `idx_facultad_activo` ON `FACULTAD` (`activo`);

CREATE UNIQUE INDEX `uk_escuela_codigo` ON `ESCUELA` (`codigo`);

CREATE INDEX `idx_escuela_facultad` ON `ESCUELA` (`fk_id_facultad`);

CREATE INDEX `idx_escuela_activo` ON `ESCUELA` (`activo`);

CREATE UNIQUE INDEX `uk_departamento_codigo` ON `DEPARTAMENTO_ACADEMICO` (`codigo`);

CREATE INDEX `idx_departamento_facultad` ON `DEPARTAMENTO_ACADEMICO` (`fk_id_facultad`);

CREATE INDEX `idx_departamento_activo` ON `DEPARTAMENTO_ACADEMICO` (`activo`);

CREATE UNIQUE INDEX `uk_area_codigo` ON `AREA_ADMINISTRATIVA` (`codigo`);

CREATE INDEX `idx_area_padre` ON `AREA_ADMINISTRATIVA` (`fk_id_area_padre`);

CREATE INDEX `idx_area_activo` ON `AREA_ADMINISTRATIVA` (`activo`);

CREATE INDEX `idx_ubigeo_completo` ON `UBIGEO` (`departamento`, `provincia`, `distrito`);

CREATE UNIQUE INDEX `uk_reporte_codigo` ON `REPORTE` (`codigo`);

CREATE INDEX `idx_reporte_categoria` ON `REPORTE` (`categoria`, `activo`);

CREATE INDEX `idx_ejecucion_reporte_fecha` ON `EJECUCION_REPORTE` (`fk_id_reporte`, `fecha_ejecucion`);

CREATE INDEX `idx_ejecucion_usuario` ON `EJECUCION_REPORTE` (`fk_id_usuario_ejecuta`);

CREATE INDEX `idx_ejecucion_estado` ON `EJECUCION_REPORTE` (`estado`);

ALTER TABLE `USUARIO` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `USUARIO` ADD FOREIGN KEY (`fk_id_usuario_modificacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ESTUDIANTE` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ESTUDIANTE` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `FACULTAD` (`id_facultad`);

ALTER TABLE `ESTUDIANTE` ADD FOREIGN KEY (`fk_id_escuela`) REFERENCES `ESCUELA` (`id_escuela`);

ALTER TABLE `ESTUDIANTE` ADD FOREIGN KEY (`fk_id_tipo_beneficiario`) REFERENCES `TIPO_BENEFICIARIO` (`id_tipo_beneficiario`);

ALTER TABLE `DOCENTE` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DOCENTE` ADD FOREIGN KEY (`fk_id_departamento`) REFERENCES `DEPARTAMENTO_ACADEMICO` (`id_departamento`);

ALTER TABLE `PERSONAL_ADMINISTRATIVO` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `PERSONAL_ADMINISTRATIVO` ADD FOREIGN KEY (`fk_id_area`) REFERENCES `AREA_ADMINISTRATIVA` (`id_area`);

ALTER TABLE `PROVEEDOR` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `PROVEEDOR` ADD FOREIGN KEY (`ubigeo`) REFERENCES `UBIGEO` (`codigo_ubigeo`);

ALTER TABLE `PROVEEDOR` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ROL` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `USUARIO_ROL` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `USUARIO_ROL` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `ROL` (`id_rol`);

ALTER TABLE `USUARIO_ROL` ADD FOREIGN KEY (`fk_id_usuario_asigna`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ROL_PERMISO` ADD FOREIGN KEY (`fk_id_rol`) REFERENCES `ROL` (`id_rol`);

ALTER TABLE `ROL_PERMISO` ADD FOREIGN KEY (`fk_id_permiso`) REFERENCES `PERMISO` (`id_permiso`);

ALTER TABLE `ROL_PERMISO` ADD FOREIGN KEY (`fk_id_usuario_asigna`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `SESION` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `PERSONA_NATURAL_RENIEC` ADD FOREIGN KEY (`ubigeo_nacimiento`) REFERENCES `UBIGEO` (`codigo_ubigeo`);

ALTER TABLE `PERSONA_NATURAL_RENIEC` ADD FOREIGN KEY (`ubigeo_domicilio`) REFERENCES `UBIGEO` (`codigo_ubigeo`);

ALTER TABLE `PERSONA_JURIDICA_SUNAT` ADD FOREIGN KEY (`ubigeo`) REFERENCES `UBIGEO` (`codigo_ubigeo`);

ALTER TABLE `CONCEPTO_INGRESO` ADD FOREIGN KEY (`fk_id_categoria_concepto`) REFERENCES `CATEGORIA_CONCEPTO` (`id_categoria_concepto`);

ALTER TABLE `CONCEPTO_INGRESO` ADD FOREIGN KEY (`clasificador_siaf`) REFERENCES `CLASIFICADOR_INGRESO` (`id_clasificador_ingreso`);

ALTER TABLE `CONCEPTO_INGRESO` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DESCUENTO` ADD FOREIGN KEY (`fk_id_tipo_beneficiario`) REFERENCES `TIPO_BENEFICIARIO` (`id_tipo_beneficiario`);

ALTER TABLE `TUPA` ADD FOREIGN KEY (`fk_id_concepto_ingreso`) REFERENCES `CONCEPTO_INGRESO` (`id_concepto_ingreso`);

ALTER TABLE `TUPA` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ACTUALIZACION_TARIFARIO` ADD FOREIGN KEY (`fk_id_tupa`) REFERENCES `TUPA` (`id_tupa`);

ALTER TABLE `ACTUALIZACION_TARIFARIO` ADD FOREIGN KEY (`fk_id_tarifario`) REFERENCES `TARIFARIO` (`id_tarifario`);

ALTER TABLE `ACTUALIZACION_TARIFARIO` ADD FOREIGN KEY (`fk_id_usuario_aprueba`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `TARIFARIO` ADD FOREIGN KEY (`fk_id_concepto_ingreso`) REFERENCES `CONCEPTO_INGRESO` (`id_concepto_ingreso`);

ALTER TABLE `TARIFARIO` ADD FOREIGN KEY (`fk_id_tupa`) REFERENCES `TUPA` (`id_tupa`);

ALTER TABLE `TARIFARIO` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `PERIODO_ACADEMICO` (`id_periodo_academico`);

ALTER TABLE `TARIFARIO` ADD FOREIGN KEY (`fk_id_tipo_beneficiario`) REFERENCES `TIPO_BENEFICIARIO` (`id_tipo_beneficiario`);

ALTER TABLE `TARIFARIO` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ORDEN_PAGO_INGRESO` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ORDEN_PAGO_INGRESO` ADD FOREIGN KEY (`fk_id_concepto_ingreso`) REFERENCES `CONCEPTO_INGRESO` (`id_concepto_ingreso`);

ALTER TABLE `ORDEN_PAGO_INGRESO` ADD FOREIGN KEY (`fk_id_periodo_academico`) REFERENCES `PERIODO_ACADEMICO` (`id_periodo_academico`);

ALTER TABLE `ORDEN_PAGO_INGRESO` ADD FOREIGN KEY (`fk_id_tarifario`) REFERENCES `TARIFARIO` (`id_tarifario`);

ALTER TABLE `ORDEN_PAGO_INGRESO` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DETALLE_ORDEN_PAGO` ADD FOREIGN KEY (`fk_id_orden_pago_ingreso`) REFERENCES `ORDEN_PAGO_INGRESO` (`id_orden_pago_ingreso`);

ALTER TABLE `DETALLE_ORDEN_PAGO` ADD FOREIGN KEY (`fk_id_concepto_ingreso`) REFERENCES `CONCEPTO_INGRESO` (`id_concepto_ingreso`);

ALTER TABLE `PAGO` ADD FOREIGN KEY (`fk_id_orden_pago_ingreso`) REFERENCES `ORDEN_PAGO_INGRESO` (`id_orden_pago_ingreso`);

ALTER TABLE `PAGO` ADD FOREIGN KEY (`fk_id_medio_pago`) REFERENCES `MEDIO_PAGO` (`id_medio_pago`);

ALTER TABLE `PAGO` ADD FOREIGN KEY (`fk_id_cuenta_bancaria_universidad`) REFERENCES `CUENTA_BANCARIA_UNIVERSIDAD` (`id_cuenta_bancaria`);

ALTER TABLE `PAGO` ADD FOREIGN KEY (`fk_id_movimiento_bancario`) REFERENCES `MOVIMIENTO_BANCARIO` (`id_movimiento_bancario`);

ALTER TABLE `PAGO` ADD FOREIGN KEY (`fk_id_caja_diaria`) REFERENCES `CAJA_DIARIA` (`id_caja_diaria`);

ALTER TABLE `PAGO` ADD FOREIGN KEY (`fk_id_turno_caja`) REFERENCES `TURNO_CAJA` (`id_turno_caja`);

ALTER TABLE `PAGO` ADD FOREIGN KEY (`fk_id_usuario_registro`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DETALLE_PAGO_CLASIFICADOR` ADD FOREIGN KEY (`fk_id_pago`) REFERENCES `PAGO` (`id_pago`);

ALTER TABLE `DETALLE_PAGO_CLASIFICADOR` ADD FOREIGN KEY (`fk_id_clasificador_ingreso`) REFERENCES `CLASIFICADOR_INGRESO` (`id_clasificador_ingreso`);

ALTER TABLE `DETALLE_PAGO_CLASIFICADOR` ADD FOREIGN KEY (`fk_id_fuente_financiamiento`) REFERENCES `FUENTE_FINANCIAMIENTO` (`id_fuente_financiamiento`);

ALTER TABLE `DETALLE_PAGO_CLASIFICADOR` ADD FOREIGN KEY (`fk_id_meta_presupuestal`) REFERENCES `META_PRESUPUESTAL` (`id_meta_presupuestal`);

ALTER TABLE `RECIBO_PAGO` ADD FOREIGN KEY (`fk_id_pago`) REFERENCES `PAGO` (`id_pago`);

ALTER TABLE `RECIBO_PAGO` ADD FOREIGN KEY (`fk_id_orden_pago_ingreso`) REFERENCES `ORDEN_PAGO_INGRESO` (`id_orden_pago_ingreso`);

ALTER TABLE `RECIBO_PAGO` ADD FOREIGN KEY (`emitido_por`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_tipo_deuda`) REFERENCES `TIPO_DEUDA` (`id_tipo_deuda`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_estado_deuda`) REFERENCES `ESTADO_DEUDA` (`id_estado_deuda`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_concepto_ingreso`) REFERENCES `CONCEPTO_INGRESO` (`id_concepto_ingreso`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_orden_pago_vencida`) REFERENCES `ORDEN_PAGO_INGRESO` (`id_orden_pago_ingreso`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_plan_pagos`) REFERENCES `PLAN_PAGOS` (`id_plan_pagos`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DEUDA` ADD FOREIGN KEY (`fk_id_usuario_modificacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `PLAN_PAGOS` ADD FOREIGN KEY (`fk_id_deuda`) REFERENCES `DEUDA` (`id_deuda`);

ALTER TABLE `PLAN_PAGOS` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `PLAN_PAGOS` ADD FOREIGN KEY (`fk_id_usuario_aprueba`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CUOTA_PLAN_PAGOS` ADD FOREIGN KEY (`fk_id_plan_pagos`) REFERENCES `PLAN_PAGOS` (`id_plan_pagos`);

ALTER TABLE `APLICACION_PAGO_DEUDA` ADD FOREIGN KEY (`fk_id_pago`) REFERENCES `PAGO` (`id_pago`);

ALTER TABLE `APLICACION_PAGO_DEUDA` ADD FOREIGN KEY (`fk_id_deuda`) REFERENCES `DEUDA` (`id_deuda`);

ALTER TABLE `APLICACION_PAGO_DEUDA` ADD FOREIGN KEY (`fk_id_cuota`) REFERENCES `CUOTA_PLAN_PAGOS` (`id_cuota`);

ALTER TABLE `APLICACION_PAGO_DEUDA` ADD FOREIGN KEY (`fk_id_usuario_aplica`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `BLOQUEO_SERVICIO` ADD FOREIGN KEY (`fk_id_deuda`) REFERENCES `DEUDA` (`id_deuda`);

ALTER TABLE `BLOQUEO_SERVICIO` ADD FOREIGN KEY (`fk_id_servicio_bloqueado`) REFERENCES `SERVICIO_BLOQUEADO` (`id_servicio_bloqueado`);

ALTER TABLE `BLOQUEO_SERVICIO` ADD FOREIGN KEY (`fk_id_usuario_bloquea`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `BLOQUEO_SERVICIO` ADD FOREIGN KEY (`fk_id_usuario_desbloquea`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `HISTORIAL_DEUDA` ADD FOREIGN KEY (`fk_id_deuda`) REFERENCES `DEUDA` (`id_deuda`);

ALTER TABLE `HISTORIAL_DEUDA` ADD FOREIGN KEY (`fk_id_usuario_cambio`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ALERTA_DEUDA` ADD FOREIGN KEY (`fk_id_deuda`) REFERENCES `DEUDA` (`id_deuda`);

ALTER TABLE `CONDONACION_DEUDA` ADD FOREIGN KEY (`fk_id_deuda`) REFERENCES `DEUDA` (`id_deuda`);

ALTER TABLE `CONDONACION_DEUDA` ADD FOREIGN KEY (`fk_id_usuario_solicita`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CONDONACION_DEUDA` ADD FOREIGN KEY (`fk_id_usuario_aprueba`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CONDONACION_DEUDA` ADD FOREIGN KEY (`fk_id_expediente`) REFERENCES `EXPEDIENTE` (`id_expediente`);

ALTER TABLE `GARANTIA` ADD FOREIGN KEY (`fk_id_plan_pagos`) REFERENCES `PLAN_PAGOS` (`id_plan_pagos`);

ALTER TABLE `GARANTIA` ADD FOREIGN KEY (`fk_id_garante`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CONVENIO_PAGO` ADD FOREIGN KEY (`fk_id_plan_pagos`) REFERENCES `PLAN_PAGOS` (`id_plan_pagos`);

ALTER TABLE `CONVENIO_PAGO` ADD FOREIGN KEY (`fk_id_deuda`) REFERENCES `DEUDA` (`id_deuda`);

ALTER TABLE `CONVENIO_PAGO` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CONVENIO_PAGO` ADD FOREIGN KEY (`fk_id_usuario_universidad`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ORDEN_COMPRA` ADD FOREIGN KEY (`fk_id_proveedor`) REFERENCES `PROVEEDOR` (`id_proveedor`);

ALTER TABLE `ORDEN_COMPRA` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ORDEN_SERVICIO` ADD FOREIGN KEY (`fk_id_proveedor`) REFERENCES `PROVEEDOR` (`id_proveedor`);

ALTER TABLE `ORDEN_SERVICIO` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `FACTURA` ADD FOREIGN KEY (`fk_id_proveedor`) REFERENCES `PROVEEDOR` (`id_proveedor`);

ALTER TABLE `FACTURA` ADD FOREIGN KEY (`fk_id_tipo_comprobante`) REFERENCES `TIPO_COMPROBANTE` (`id_tipo_comprobante`);

ALTER TABLE `FACTURA` ADD FOREIGN KEY (`fk_id_orden_compra`) REFERENCES `ORDEN_COMPRA` (`id_orden_compra`);

ALTER TABLE `FACTURA` ADD FOREIGN KEY (`fk_id_orden_servicio`) REFERENCES `ORDEN_SERVICIO` (`id_orden_servicio`);

ALTER TABLE `FACTURA` ADD FOREIGN KEY (`fk_id_usuario_registro`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DETALLE_FACTURA` ADD FOREIGN KEY (`fk_id_factura`) REFERENCES `FACTURA` (`id_factura`);

ALTER TABLE `CONFORMIDAD` ADD FOREIGN KEY (`fk_id_factura`) REFERENCES `FACTURA` (`id_factura`);

ALTER TABLE `CONFORMIDAD` ADD FOREIGN KEY (`fk_id_orden_compra`) REFERENCES `ORDEN_COMPRA` (`id_orden_compra`);

ALTER TABLE `CONFORMIDAD` ADD FOREIGN KEY (`fk_id_orden_servicio`) REFERENCES `ORDEN_SERVICIO` (`id_orden_servicio`);

ALTER TABLE `CONFORMIDAD` ADD FOREIGN KEY (`fk_id_usuario_responsable`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DEVENGADO` ADD FOREIGN KEY (`fk_id_factura`) REFERENCES `FACTURA` (`id_factura`);

ALTER TABLE `DEVENGADO` ADD FOREIGN KEY (`fk_id_conformidad`) REFERENCES `CONFORMIDAD` (`id_conformidad`);

ALTER TABLE `DEVENGADO` ADD FOREIGN KEY (`fk_id_usuario_registro`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DETALLE_DEVENGADO` ADD FOREIGN KEY (`fk_id_devengado`) REFERENCES `DEVENGADO` (`id_devengado`);

ALTER TABLE `DETALLE_DEVENGADO` ADD FOREIGN KEY (`fk_id_clasificador_gasto`) REFERENCES `CLASIFICADOR_GASTO` (`id_clasificador_gasto`);

ALTER TABLE `DETALLE_DEVENGADO` ADD FOREIGN KEY (`fk_id_fuente_financiamiento`) REFERENCES `FUENTE_FINANCIAMIENTO` (`id_fuente_financiamiento`);

ALTER TABLE `DETALLE_DEVENGADO` ADD FOREIGN KEY (`fk_id_meta_presupuestal`) REFERENCES `META_PRESUPUESTAL` (`id_meta_presupuestal`);

ALTER TABLE `ORDEN_PAGO_EGRESO` ADD FOREIGN KEY (`fk_id_devengado`) REFERENCES `DEVENGADO` (`id_devengado`);

ALTER TABLE `ORDEN_PAGO_EGRESO` ADD FOREIGN KEY (`fk_id_proveedor`) REFERENCES `PROVEEDOR` (`id_proveedor`);

ALTER TABLE `ORDEN_PAGO_EGRESO` ADD FOREIGN KEY (`fk_id_usuario_autoriza`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ORDEN_PAGO_EGRESO` ADD FOREIGN KEY (`fk_id_usuario_registro`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CUENTA_BANCARIA_PROVEEDOR` ADD FOREIGN KEY (`fk_id_proveedor`) REFERENCES `PROVEEDOR` (`id_proveedor`);

ALTER TABLE `CUENTA_BANCARIA_PROVEEDOR` ADD FOREIGN KEY (`fk_id_banco`) REFERENCES `BANCO` (`id_banco`);

ALTER TABLE `PAGO_PROVEEDOR` ADD FOREIGN KEY (`fk_id_orden_pago_egreso`) REFERENCES `ORDEN_PAGO_EGRESO` (`id_orden_pago_egreso`);

ALTER TABLE `PAGO_PROVEEDOR` ADD FOREIGN KEY (`fk_id_cuenta_bancaria_proveedor`) REFERENCES `CUENTA_BANCARIA_PROVEEDOR` (`id_cuenta_bancaria_proveedor`);

ALTER TABLE `PAGO_PROVEEDOR` ADD FOREIGN KEY (`fk_id_cuenta_bancaria_universidad`) REFERENCES `CUENTA_BANCARIA_UNIVERSIDAD` (`id_cuenta_bancaria`);

ALTER TABLE `PAGO_PROVEEDOR` ADD FOREIGN KEY (`fk_id_movimiento_bancario`) REFERENCES `MOVIMIENTO_BANCARIO` (`id_movimiento_bancario`);

ALTER TABLE `PAGO_PROVEEDOR` ADD FOREIGN KEY (`fk_id_usuario_ejecuta`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `RETENCION` ADD FOREIGN KEY (`fk_id_pago_proveedor`) REFERENCES `PAGO_PROVEEDOR` (`id_pago_proveedor`);

ALTER TABLE `CAJA_CHICA` ADD FOREIGN KEY (`fk_id_area`) REFERENCES `AREA_ADMINISTRATIVA` (`id_area`);

ALTER TABLE `CAJA_CHICA` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `RESPONSABLE_CAJA_CHICA` ADD FOREIGN KEY (`fk_id_caja_chica`) REFERENCES `CAJA_CHICA` (`id_caja_chica`);

ALTER TABLE `RESPONSABLE_CAJA_CHICA` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `SOLICITUD_GASTO` ADD FOREIGN KEY (`fk_id_caja_chica`) REFERENCES `CAJA_CHICA` (`id_caja_chica`);

ALTER TABLE `SOLICITUD_GASTO` ADD FOREIGN KEY (`fk_id_usuario_solicitante`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `SOLICITUD_GASTO` ADD FOREIGN KEY (`fk_id_tipo_gasto`) REFERENCES `TIPO_GASTO_CAJA_CHICA` (`id_tipo_gasto`);

ALTER TABLE `APROBACION_SOLICITUD` ADD FOREIGN KEY (`fk_id_solicitud`) REFERENCES `SOLICITUD_GASTO` (`id_solicitud`);

ALTER TABLE `APROBACION_SOLICITUD` ADD FOREIGN KEY (`fk_id_usuario_aprobador`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ENTREGA_EFECTIVO` ADD FOREIGN KEY (`fk_id_solicitud`) REFERENCES `SOLICITUD_GASTO` (`id_solicitud`);

ALTER TABLE `ENTREGA_EFECTIVO` ADD FOREIGN KEY (`fk_id_usuario_entrega`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `RENDICION_GASTO` ADD FOREIGN KEY (`fk_id_solicitud`) REFERENCES `SOLICITUD_GASTO` (`id_solicitud`);

ALTER TABLE `RENDICION_GASTO` ADD FOREIGN KEY (`fk_id_comprobante`) REFERENCES `COMPROBANTE_GASTO` (`id_comprobante`);

ALTER TABLE `RENDICION_GASTO` ADD FOREIGN KEY (`fk_id_usuario_aprueba_rendicion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DETALLE_RENDICION` ADD FOREIGN KEY (`fk_id_rendicion`) REFERENCES `RENDICION_GASTO` (`id_rendicion`);

ALTER TABLE `DETALLE_RENDICION` ADD FOREIGN KEY (`fk_id_clasificador_gasto`) REFERENCES `CLASIFICADOR_GASTO` (`id_clasificador_gasto`);

ALTER TABLE `REEMBOLSO_CAJA_CHICA` ADD FOREIGN KEY (`fk_id_caja_chica`) REFERENCES `CAJA_CHICA` (`id_caja_chica`);

ALTER TABLE `REEMBOLSO_CAJA_CHICA` ADD FOREIGN KEY (`fk_id_usuario_solicita`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `RENDICION_REEMBOLSO` ADD FOREIGN KEY (`fk_id_reembolso`) REFERENCES `REEMBOLSO_CAJA_CHICA` (`id_reembolso`);

ALTER TABLE `RENDICION_REEMBOLSO` ADD FOREIGN KEY (`fk_id_rendicion`) REFERENCES `RENDICION_GASTO` (`id_rendicion`);

ALTER TABLE `ARQUEO_CAJA_CHICA` ADD FOREIGN KEY (`fk_id_caja_chica`) REFERENCES `CAJA_CHICA` (`id_caja_chica`);

ALTER TABLE `ARQUEO_CAJA_CHICA` ADD FOREIGN KEY (`fk_id_usuario_arquea`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CAJA_DIARIA` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CAJERO` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CAJERO` ADD FOREIGN KEY (`fk_id_caja_diaria`) REFERENCES `CAJA_DIARIA` (`id_caja_diaria`);

ALTER TABLE `TURNO_CAJA` ADD FOREIGN KEY (`fk_id_caja_diaria`) REFERENCES `CAJA_DIARIA` (`id_caja_diaria`);

ALTER TABLE `TURNO_CAJA` ADD FOREIGN KEY (`fk_id_cajero`) REFERENCES `CAJERO` (`id_cajero`);

ALTER TABLE `APERTURA_CAJA` ADD FOREIGN KEY (`fk_id_turno_caja`) REFERENCES `TURNO_CAJA` (`id_turno_caja`);

ALTER TABLE `CIERRE_CAJA` ADD FOREIGN KEY (`fk_id_turno_caja`) REFERENCES `TURNO_CAJA` (`id_turno_caja`);

ALTER TABLE `MOVIMIENTO_CAJA` ADD FOREIGN KEY (`fk_id_turno_caja`) REFERENCES `TURNO_CAJA` (`id_turno_caja`);

ALTER TABLE `MOVIMIENTO_CAJA` ADD FOREIGN KEY (`fk_id_pago`) REFERENCES `PAGO` (`id_pago`);

ALTER TABLE `ARQUEO_CAJA_DIARIA` ADD FOREIGN KEY (`fk_id_turno_caja`) REFERENCES `TURNO_CAJA` (`id_turno_caja`);

ALTER TABLE `ARQUEO_CAJA_DIARIA` ADD FOREIGN KEY (`fk_id_usuario_arquea`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DEPOSITO_BANCARIO` ADD FOREIGN KEY (`fk_id_caja_diaria`) REFERENCES `CAJA_DIARIA` (`id_caja_diaria`);

ALTER TABLE `DEPOSITO_BANCARIO` ADD FOREIGN KEY (`fk_id_cuenta_bancaria_universidad`) REFERENCES `CUENTA_BANCARIA_UNIVERSIDAD` (`id_cuenta_bancaria`);

ALTER TABLE `DEPOSITO_BANCARIO` ADD FOREIGN KEY (`fk_id_movimiento_bancario`) REFERENCES `MOVIMIENTO_BANCARIO` (`id_movimiento_bancario`);

ALTER TABLE `DEPOSITO_BANCARIO` ADD FOREIGN KEY (`fk_id_usuario_deposita`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DIFERENCIA_CAJA` ADD FOREIGN KEY (`fk_id_cierre_caja`) REFERENCES `CIERRE_CAJA` (`id_cierre_caja`);

ALTER TABLE `DIFERENCIA_CAJA` ADD FOREIGN KEY (`fk_id_arqueo_caja_diaria`) REFERENCES `ARQUEO_CAJA_DIARIA` (`id_arqueo_caja_diaria`);

ALTER TABLE `DIFERENCIA_CAJA` ADD FOREIGN KEY (`fk_id_usuario_justifica`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DIFERENCIA_CAJA` ADD FOREIGN KEY (`fk_id_usuario_aprueba`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CUENTA_BANCARIA_UNIVERSIDAD` ADD FOREIGN KEY (`fk_id_banco`) REFERENCES `BANCO` (`id_banco`);

ALTER TABLE `CUENTA_BANCARIA_UNIVERSIDAD` ADD FOREIGN KEY (`fk_id_fuente_financiamiento`) REFERENCES `FUENTE_FINANCIAMIENTO` (`id_fuente_financiamiento`);

ALTER TABLE `CUENTA_BANCARIA_UNIVERSIDAD` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `MOVIMIENTO_BANCARIO` ADD FOREIGN KEY (`fk_id_cuenta_bancaria`) REFERENCES `CUENTA_BANCARIA_UNIVERSIDAD` (`id_cuenta_bancaria`);

ALTER TABLE `MOVIMIENTO_BANCARIO` ADD FOREIGN KEY (`fk_id_pago`) REFERENCES `PAGO` (`id_pago`);

ALTER TABLE `MOVIMIENTO_BANCARIO` ADD FOREIGN KEY (`fk_id_pago_proveedor`) REFERENCES `PAGO_PROVEEDOR` (`id_pago_proveedor`);

ALTER TABLE `MOVIMIENTO_BANCARIO` ADD FOREIGN KEY (`fk_id_usuario_registro`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ARCHIVO_BANCO` ADD FOREIGN KEY (`fk_id_cuenta_bancaria`) REFERENCES `CUENTA_BANCARIA_UNIVERSIDAD` (`id_cuenta_bancaria`);

ALTER TABLE `ARCHIVO_BANCO` ADD FOREIGN KEY (`fk_id_usuario_subida`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CONCILIACION_BANCARIA` ADD FOREIGN KEY (`fk_id_cuenta_bancaria`) REFERENCES `CUENTA_BANCARIA_UNIVERSIDAD` (`id_cuenta_bancaria`);

ALTER TABLE `CONCILIACION_BANCARIA` ADD FOREIGN KEY (`fk_id_usuario_concilia`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CONCILIACION_BANCARIA` ADD FOREIGN KEY (`fk_id_usuario_aprueba`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DETALLE_CONCILIACION` ADD FOREIGN KEY (`fk_id_conciliacion`) REFERENCES `CONCILIACION_BANCARIA` (`id_conciliacion`);

ALTER TABLE `DETALLE_CONCILIACION` ADD FOREIGN KEY (`fk_id_movimiento_bancario`) REFERENCES `MOVIMIENTO_BANCARIO` (`id_movimiento_bancario`);

ALTER TABLE `DETALLE_CONCILIACION` ADD FOREIGN KEY (`fk_id_pago`) REFERENCES `PAGO` (`id_pago`);

ALTER TABLE `DETALLE_CONCILIACION` ADD FOREIGN KEY (`fk_id_pago_proveedor`) REFERENCES `PAGO_PROVEEDOR` (`id_pago_proveedor`);

ALTER TABLE `ERROR_CONCILIACION` ADD FOREIGN KEY (`fk_id_conciliacion`) REFERENCES `CONCILIACION_BANCARIA` (`id_conciliacion`);

ALTER TABLE `ERROR_CONCILIACION` ADD FOREIGN KEY (`fk_id_movimiento_bancario`) REFERENCES `MOVIMIENTO_BANCARIO` (`id_movimiento_bancario`);

ALTER TABLE `ERROR_CONCILIACION` ADD FOREIGN KEY (`fk_id_usuario_resuelve`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `META_PRESUPUESTAL` ADD FOREIGN KEY (`fk_id_fuente_financiamiento`) REFERENCES `FUENTE_FINANCIAMIENTO` (`id_fuente_financiamiento`);

ALTER TABLE `CERTIFICACION_PRESUPUESTAL` ADD FOREIGN KEY (`fk_id_meta_presupuestal`) REFERENCES `META_PRESUPUESTAL` (`id_meta_presupuestal`);

ALTER TABLE `CERTIFICACION_PRESUPUESTAL` ADD FOREIGN KEY (`fk_id_clasificador_gasto`) REFERENCES `CLASIFICADOR_GASTO` (`id_clasificador_gasto`);

ALTER TABLE `CERTIFICACION_PRESUPUESTAL` ADD FOREIGN KEY (`fk_id_expediente`) REFERENCES `EXPEDIENTE` (`id_expediente`);

ALTER TABLE `CERTIFICACION_PRESUPUESTAL` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `NOTA_CONTABLE_SIAF` ADD FOREIGN KEY (`fk_id_devengado`) REFERENCES `DEVENGADO` (`id_devengado`);

ALTER TABLE `NOTA_CONTABLE_SIAF` ADD FOREIGN KEY (`fk_id_pago`) REFERENCES `PAGO` (`id_pago`);

ALTER TABLE `DETALLE_NOTA_CONTABLE` ADD FOREIGN KEY (`fk_id_nota_contable`) REFERENCES `NOTA_CONTABLE_SIAF` (`id_nota_contable`);

ALTER TABLE `DETALLE_NOTA_CONTABLE` ADD FOREIGN KEY (`fk_id_clasificador_gasto`) REFERENCES `CLASIFICADOR_GASTO` (`id_clasificador_gasto`);

ALTER TABLE `DETALLE_NOTA_CONTABLE` ADD FOREIGN KEY (`fk_id_fuente_financiamiento`) REFERENCES `FUENTE_FINANCIAMIENTO` (`id_fuente_financiamiento`);

ALTER TABLE `DETALLE_NOTA_CONTABLE` ADD FOREIGN KEY (`fk_id_meta_presupuestal`) REFERENCES `META_PRESUPUESTAL` (`id_meta_presupuestal`);

ALTER TABLE `EJECUCION_PRESUPUESTAL` ADD FOREIGN KEY (`fk_id_meta_presupuestal`) REFERENCES `META_PRESUPUESTAL` (`id_meta_presupuestal`);

ALTER TABLE `EJECUCION_PRESUPUESTAL` ADD FOREIGN KEY (`fk_id_clasificador_gasto`) REFERENCES `CLASIFICADOR_GASTO` (`id_clasificador_gasto`);

ALTER TABLE `EXPEDIENTE` ADD FOREIGN KEY (`fk_id_usuario_solicitante`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `PROCESO_WORKFLOW` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `INSTANCIA_WORKFLOW` ADD FOREIGN KEY (`fk_id_expediente`) REFERENCES `EXPEDIENTE` (`id_expediente`);

ALTER TABLE `INSTANCIA_WORKFLOW` ADD FOREIGN KEY (`fk_id_proceso`) REFERENCES `PROCESO_WORKFLOW` (`id_proceso`);

ALTER TABLE `TAREA` ADD FOREIGN KEY (`fk_id_instancia`) REFERENCES `INSTANCIA_WORKFLOW` (`id_instancia`);

ALTER TABLE `TAREA` ADD FOREIGN KEY (`fk_id_rol_asignado`) REFERENCES `ROL` (`id_rol`);

ALTER TABLE `TAREA` ADD FOREIGN KEY (`fk_id_usuario_asignado`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `SLA_WORKFLOW` ADD FOREIGN KEY (`fk_id_proceso`) REFERENCES `PROCESO_WORKFLOW` (`id_proceso`);

ALTER TABLE `SLA_WORKFLOW` ADD FOREIGN KEY (`fk_id_rol_escalamiento`) REFERENCES `ROL` (`id_rol`);

ALTER TABLE `HISTORIAL_TAREA` ADD FOREIGN KEY (`fk_id_tarea`) REFERENCES `TAREA` (`id_tarea`);

ALTER TABLE `HISTORIAL_TAREA` ADD FOREIGN KEY (`fk_id_usuario_accion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `LOG_AUDITORIA` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `LOG_ACCESO` ADD FOREIGN KEY (`fk_id_usuario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `DOCUMENTO` ADD FOREIGN KEY (`fk_id_usuario_subida`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `VERSION_DOCUMENTO` ADD FOREIGN KEY (`fk_id_documento`) REFERENCES `DOCUMENTO` (`id_documento`);

ALTER TABLE `VERSION_DOCUMENTO` ADD FOREIGN KEY (`fk_id_usuario_cambio`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `VALOR_INDICADOR` ADD FOREIGN KEY (`fk_id_kpi`) REFERENCES `INDICADOR_KPI` (`id_kpi`);

ALTER TABLE `NOTIFICACION` ADD FOREIGN KEY (`fk_id_usuario_destinatario`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `CONFIGURACION_SISTEMA` ADD FOREIGN KEY (`fk_id_usuario_modificacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `PARAMETRO_SISTEMA` ADD FOREIGN KEY (`fk_id_usuario_modificacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `ESCUELA` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `FACULTAD` (`id_facultad`);

ALTER TABLE `DEPARTAMENTO_ACADEMICO` ADD FOREIGN KEY (`fk_id_facultad`) REFERENCES `FACULTAD` (`id_facultad`);

ALTER TABLE `AREA_ADMINISTRATIVA` ADD FOREIGN KEY (`fk_id_area_padre`) REFERENCES `AREA_ADMINISTRATIVA` (`id_area`);

ALTER TABLE `REPORTE` ADD FOREIGN KEY (`fk_id_usuario_creacion`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `EJECUCION_REPORTE` ADD FOREIGN KEY (`fk_id_reporte`) REFERENCES `REPORTE` (`id_reporte`);

ALTER TABLE `EJECUCION_REPORTE` ADD FOREIGN KEY (`fk_id_usuario_ejecuta`) REFERENCES `USUARIO` (`id_usuario`);

ALTER TABLE `NOTA_CONTABLE_SIAF` ADD FOREIGN KEY (`fecha_nota`) REFERENCES `ARCHIVO_BANCO` (`tamanio_bytes`);
