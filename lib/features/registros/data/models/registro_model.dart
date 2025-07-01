import '../../domain/entities/registro_entity.dart';

class RegistroModel extends RegistroEntity {
  RegistroModel({
    required super.nombreAsesor,
    required super.idRegistro,
    super.abogadoQueRecepciona,
    required super.fechaIngresoDatos,
    required super.nombreCompletoCliente,
    super.rutCliente,
    required super.codigoAsesor,
    super.dniExt,
    super.emailCliente,
    required super.fonoContactoCliente,
    super.cierre1eraCita,
    super.fecha2doLlamado,
    super.segundoLlamado,
    super.fechaSegundaCita,
    super.cierreEn2daCita,
    super.fecha3erLlamado,
    super.tercerLlamado,
    super.fechaTerceraCita,
    super.cierreEn3eraCita,
    super.comisionPorCierre,
    super.procedimiento,
    super.fechaDeCierre,
    super.periodoCierre,
  });

// fromJson
  factory RegistroModel.fromJson(Map<String, Object?> json) {
    final fonoContactoCliente = _getFonoContacto(json['fono_contacto_cliente']);

    return RegistroModel(
      nombreAsesor: json['nombre_asesor'] as String,
      idRegistro: json['id_registro'] as String,
      abogadoQueRecepciona: json['abogado_que_recepciona'] as String?,
      fechaIngresoDatos: DateTime.parse(json['fecha_ingreso_datos'] as String),
      nombreCompletoCliente: json['nombre_completo_cliente'] as String,
      rutCliente: json['rut_cliente'] as String?,
      codigoAsesor: json['codigo_asesor'] as String,
      dniExt: json['dni_ext'] as String?,
      emailCliente: json['email_cliente'] as String?,
      fonoContactoCliente: fonoContactoCliente,
      cierre1eraCita: json['cierre_1era_cita'] as String?,
      fecha2doLlamado: json['fecha_2do_llamado'] != null 
          ? DateTime.parse(json['fecha_2do_llamado'] as String)
          : null,
      segundoLlamado: json['segundo_llamado'] as String?,
      fechaSegundaCita: json['fecha_segunda_cita'] != null 
          ? DateTime.parse(json['fecha_segunda_cita'] as String)
          : null,
      cierreEn2daCita: json['cierre_en_2da_cita'] as String?,
      fecha3erLlamado: json['fecha_3er_llamado'] != null 
          ? DateTime.parse(json['fecha_3er_llamado'] as String)
          : null,
      tercerLlamado: json['tercer_llamado'] as String?,
      fechaTerceraCita: json['fecha_tercera_cita'] != null 
          ? DateTime.parse(json['fecha_tercera_cita'] as String)
          : null,
      cierreEn3eraCita: json['cierre_en_3era_cita'] as String?,
      comisionPorCierre: json['comision_por_cierre'] as num?,
      procedimiento: json['procedimiento'] as String?,
      fechaDeCierre: json['fecha_de_cierre'] != null 
          ? DateTime.parse(json['fecha_de_cierre'] as String)
          : null,
      periodoCierre: json['periodo_cierre'] as String?,
    );
  }

  // toJson
  Map<String, Object?> toJson() {
    return {
      'nombre_asesor': nombreAsesor,
      'id_registro': idRegistro,
      'abogado_que_recepciona': abogadoQueRecepciona,
      'fecha_ingreso_datos': fechaIngresoDatos.toIso8601String(),
      'nombre_completo_cliente': nombreCompletoCliente,
      'rut_cliente': rutCliente,
      'codigo_asesor': codigoAsesor,
      'dni_ext': dniExt,
      'email_cliente': emailCliente,
      'fono_contacto_cliente': fonoContactoCliente,
      'cierre_1era_cita': cierre1eraCita,
      'fecha_2do_llamado': fecha2doLlamado?.toIso8601String(),
      'segundo_llamado': segundoLlamado,
      'fecha_segunda_cita': fechaSegundaCita?.toIso8601String(),
      'cierre_en_2da_cita': cierreEn2daCita,
      'fecha_3er_llamado': fecha3erLlamado?.toIso8601String(),
      'tercer_llamado': tercerLlamado,
      'fecha_tercera_cita': fechaTerceraCita?.toIso8601String(),
      'cierre_en_3era_cita': cierreEn3eraCita,
      'comision_por_cierre': comisionPorCierre,
      'procedimiento': procedimiento,
      'fecha_de_cierre': fechaDeCierre?.toIso8601String(),
      'periodo_cierre': periodoCierre,
    };
  }

  // copyWith
  RegistroModel copyWith({
    String? nombreAsesor,
    String? idRegistro,
    String? abogadoQueRecepciona,
    DateTime? fechaIngresoDatos,
    String? nombreCompletoCliente,
    String? rutCliente,
    String? codigoAsesor,
    String? dniExt,
    String? emailCliente,
    String? fonoContactoCliente,
    String? cierre1eraCita,
    DateTime? fecha2doLlamado,
    String? segundoLlamado,
    DateTime? fechaSegundaCita,
    String? cierreEn2daCita,
    DateTime? fecha3erLlamado,
    String? tercerLlamado,
    DateTime? fechaTerceraCita,
    String? cierreEn3eraCita,
    double? comisionPorCierre,
    String? procedimiento,
    DateTime? fechaDeCierre,
    String? periodoCierre,
  }) {
    return RegistroModel(
      nombreAsesor: nombreAsesor ?? this.nombreAsesor,
      idRegistro: idRegistro ?? this.idRegistro,
      abogadoQueRecepciona: abogadoQueRecepciona ?? this.abogadoQueRecepciona,
      fechaIngresoDatos: fechaIngresoDatos ?? this.fechaIngresoDatos,
      nombreCompletoCliente: nombreCompletoCliente ?? this.nombreCompletoCliente,
      rutCliente: rutCliente ?? this.rutCliente,
      codigoAsesor: codigoAsesor ?? this.codigoAsesor,
      dniExt: dniExt ?? this.dniExt,
      emailCliente: emailCliente ?? this.emailCliente,
      fonoContactoCliente: fonoContactoCliente ?? this.fonoContactoCliente,
      cierre1eraCita: cierre1eraCita ?? this.cierre1eraCita,
      fecha2doLlamado: fecha2doLlamado ?? this.fecha2doLlamado,
      segundoLlamado: segundoLlamado ?? this.segundoLlamado,
      fechaSegundaCita: fechaSegundaCita ?? this.fechaSegundaCita,
      cierreEn2daCita: cierreEn2daCita ?? this.cierreEn2daCita,
      fecha3erLlamado: fecha3erLlamado ?? this.fecha3erLlamado,
      tercerLlamado: tercerLlamado ?? this.tercerLlamado,
      fechaTerceraCita: fechaTerceraCita ?? this.fechaTerceraCita,
      cierreEn3eraCita: cierreEn3eraCita ?? this.cierreEn3eraCita,
      comisionPorCierre: comisionPorCierre ?? this.comisionPorCierre,
      procedimiento: procedimiento ?? this.procedimiento,
      fechaDeCierre: fechaDeCierre ?? this.fechaDeCierre,
      periodoCierre: periodoCierre ?? this.periodoCierre,
    );
  }

  // fromEntity
  factory RegistroModel.fromEntity(RegistroEntity entity) {
    return RegistroModel(
      nombreAsesor: entity.nombreAsesor,
      idRegistro: entity.idRegistro,
      abogadoQueRecepciona: entity.abogadoQueRecepciona,
      fechaIngresoDatos: entity.fechaIngresoDatos,
      nombreCompletoCliente: entity.nombreCompletoCliente,
      rutCliente: entity.rutCliente,
      codigoAsesor: entity.codigoAsesor,
      dniExt: entity.dniExt,
      emailCliente: entity.emailCliente,
      fonoContactoCliente: entity.fonoContactoCliente,
      cierre1eraCita: entity.cierre1eraCita,
      fecha2doLlamado: entity.fecha2doLlamado,
      segundoLlamado: entity.segundoLlamado,
      fechaSegundaCita: entity.fechaSegundaCita,
      cierreEn2daCita: entity.cierreEn2daCita,
      fecha3erLlamado: entity.fecha3erLlamado,
      tercerLlamado: entity.tercerLlamado,
      fechaTerceraCita: entity.fechaTerceraCita,
      cierreEn3eraCita: entity.cierreEn3eraCita,
      comisionPorCierre: entity.comisionPorCierre,
      procedimiento: entity.procedimiento,
      fechaDeCierre: entity.fechaDeCierre,
      periodoCierre: entity.periodoCierre,
    );
  }
  
  static String _getFonoContacto(Object? json) {

    if (json is int) {
      return '$json';
    }
    return json as String;
  }
}