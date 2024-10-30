class Nave {
  var velocidad = 0
  var direccion = 0
  var combustible = 0

  method initialize() {
    if (not velocidad.between(0, 100000) or
        not direccion.between(-10,10))
      self.error("No se puede instanciar")
  }

  method acelerar(cantidad) {
    velocidad = 100000.min(velocidad + cantidad)
  }  
  
  method desacelerar(cantidad) {
    velocidad = 0.max(velocidad - cantidad)
  }

  method velocidad() = velocidad
  
  method irHaciaElSol() {
    direccion = 10
  }

  method escaparseDelSol() {
    direccion = -10
  }

  method ponerseParaleloAlSol() {
    direccion = 0
  }

  method acercarseUnPocoAlSol() {
    direccion = 10.min(direccion + 1)
  }

  method alejarseUnPocoDelSol() {
    direccion = -10.max(direccion - 1)
  }

  method cargarCombustible(cantidad) {
    combustible += cantidad
  }

  method descargarCombustible(cantidad) {
    combustible = 0.max(combustible- cantidad)
  }

  method cantidadCombustible() = combustible

  method estaTranquila() = combustible >= 4000 and velocidad <= 12000

  method prepararViaje()

  method accionAdicional() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
}

class NaveBaliza inherits Nave {
  var colorBaliza
  
  method cambiarColorDeBaliza(color) {
  const coloresPermitidos = ["verde","rojo","azul"]
    if (not coloresPermitidos.contains(color))
      self.error("No es un color permitido")
    colorBaliza = color
  }

  override method prepararViaje(){
    colorBaliza = "Verde"
    self.ponerseParaleloAlSol()
    self.accionAdicional()
  }

  override method estaTranquila() {
    return
    super() and colorBaliza != "Rojo"
  }
}

class NaveDePasajeros inherits Nave {
  const property cantidadDePasajeros 
  var racionesComida
  var racionesBebida

  method cargarComida(cantidad) {
    racionesComida += cantidad
  }

  method descargarComida(cantidad) {
    racionesComida = 0.max(racionesComida - cantidad)
  }

    method cargarBebida(cantidad) {
    racionesBebida += cantidad
  }
  
  method descargarBebida(cantidad) {
    racionesBebida = 0.max(racionesComida - cantidad)
  }

  override method prepararViaje() {
    racionesComida = 4 * cantidadDePasajeros
    racionesBebida = 6 * cantidadDePasajeros
    self.acercarseUnPocoAlSol()
    self.accionAdicional()
  }
}

class NaveDeCombate inherits Nave {
  var estaVisible = true
  var misilesDesplegados = false
  const property mensajesEmitidos = []
  method ponerseInvisible() {
    estaVisible = false
  }

    method ponerseVisible() {
    estaVisible = true
  }

  method estaInvisible() = not estaVisible

  method desplegarMisiles() {
    misilesDesplegados = true
  } 

  method replegarMisiles() {
    misilesDesplegados = false
  } 

  method emitirMensaje(mensaje) {
    mensajesEmitidos.add(mensaje)
  }

  method primerMensajeEmitido() = mensajesEmitidos.first()

  method ultimoMensajeEmitido() = mensajesEmitidos.last() 

  method esEscueta() = mensajesEmitidos.all {m => m.size()<=30}
  
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)

  override method prepararViaje() {
    misilesDesplegados = false
    self.accionAdicional()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }

  override method estaTranquila() {
    return
    super() and misilesDesplegados 
  }
}

class NaveHospital inherits NaveDePasajeros {
  var property quirofanosPreparados = false

  override method estaTranquila() {
    return
    not quirofanosPreparados
  }
}

class NaveDeCombateSigilosa inherits NaveDeCombate {
  override method estaTranquila() {
    return
    super() and estaVisible
  }
}