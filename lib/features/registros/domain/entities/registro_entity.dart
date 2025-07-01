class RegistroEntity {
  final String nombreAsesor;//0
  final String idRegistro; // "AC-05.timeStamp"
  final String? abogadoQueRecepciona;
  final DateTime fechaIngresoDatos;
  final String nombreCompletoCliente; // Obligatorio para el formulario
  final String? rutCliente;
  final String codigoAsesor;
  final String? dniExt;
  final String? emailCliente;
  final String fonoContactoCliente; // Obligatorio para el formulario

  final String? cierre1eraCita;

  final DateTime? fecha2doLlamado;
  final String? segundoLlamado;
  final DateTime? fechaSegundaCita;
  final String? cierreEn2daCita;

  final DateTime? fecha3erLlamado;
  final String? tercerLlamado;
  final DateTime? fechaTerceraCita;
  final String? cierreEn3eraCita;

  final num? comisionPorCierre;
  final String? procedimiento;
  final DateTime? fechaDeCierre;
  final String? periodoCierre;

  RegistroEntity({
    required this.nombreAsesor,
    required this.idRegistro,
    this.abogadoQueRecepciona,
    required this.fechaIngresoDatos,
    required this.nombreCompletoCliente,
    this.rutCliente,
    required this.codigoAsesor,
    this.dniExt,
    this.emailCliente,
    required this.fonoContactoCliente,
    this.cierre1eraCita,
    this.fecha2doLlamado,
    this.segundoLlamado,
    this.fechaSegundaCita,
    this.cierreEn2daCita,
    this.fecha3erLlamado,
    this.tercerLlamado,
    this.fechaTerceraCita,
    this.cierreEn3eraCita,
    this.comisionPorCierre,
    this.procedimiento,
    this.fechaDeCierre,
    this.periodoCierre,
  });
}
