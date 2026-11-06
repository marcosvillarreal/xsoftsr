# Memoria del proyecto Santa Rossa

## Descuento por pago en efectivo (regfacvtapub + pidoefectivo)

### Estado al 06/11/2026
- Instalado en `FORMS\venta`. No probado con datos reales.
- Marcos revisó el resultado del 06/11 y dijo que está bien; no detalló qué probó.
- La oferta queda inactiva mientras `TOPEEFECTIVODESC` no exista o valga 0.

### Pendientes
1. Definir el porcentaje y dar de alta `TOPEEFECTIVODESC` en `ParaVario` (valor en `importe`). Antes, verificar que `nombre` admita sus 16 caracteres: si lo corta, el LOCATE no lo encuentra y la oferta no aparece.
2. Agregar `pidoefectivo` a `gestion.pjx` (al 06/11 no estaba).
3. Averiguar los `.t.` que Marcos vio en pantalla. Causa sin confirmar: no se reprodujo y `regfacvtapub` no tiene `?` ni `SET TALK`. Falta saber dónde y cuándo aparecen.
4. Probar con datos:
   - renglones con descuento en 0, menor y mayor al tope;
   - promociones y combos;
   - NO vuelve al total exacto;
   - ACEPTAR y después No en la confirmación;
   - ACEPTAR con `SALONCDO=1` bajo `TopeCF` (remito con descuento);
   - CAEA real;
   - diseño de `pidoefectivo` (legibilidad sobre el fondo) y tecla Esc.

### Reglas decididas
- Un renglón con `despor` menor a `TopeEfectivoDesc` queda en el tope (no se suma). Si ya es mayor, no cambia.
- Promociones y combos quedan afuera.
- Sin oferta: cuenta corriente, `facturacosto=1`, clientes con convenio o reintegro (`aliconvenio` / `alireintegro` distintos de 0).
- Contado pendiente sí recibe la oferta. NC, devoluciones y presupuestos también: si hay que anular la factura, el total tiene que coincidir.
- El aviso aparece solo si el ahorro es mayor a 0.
- Hay que escribir un código aleatorio para habilitar ACEPTAR y NO. Esc no hace nada.
- Se mantiene la conversión a remito de `SALONCDO` por tope.
- El plan de pago no cambia al aceptar: el valor real entra al final del día en otro módulo.

### Flujo
`pidofinanciacion` llama a `efectivo_aplicar`, que guarda `despor` en `desporori`, sube al tope los renglones elegibles, recalcula y devuelve el ahorro. Si el ahorro es mayor a 0 abre `pidoefectivo`:
- **NO:** `efectivo_restaurar` y sigue por `pidoplanpago`.
- **ACEPTAR:** no pasa por `pidoplanpago`; hace INSERT en `CsrFinancia` con `esclase='CDO'` y sigue con `finan_totalcomproba`, DNI y `pidovalores`.

`actualizar` restaura los descuentos si `pidofinanciacion` da `.F.`, si responden No en la confirmación o si hay ROLLBACK.

Técnica: se recalcula con `SoloRecalcularPrecio=.T.` y `Calcularcombo=.F.`, porque el modo normal de `grid2_control` pisa `despor` y borra promociones.

### Cambios
- **05/11/2026:** `regfacvtapub` modificado y `pidoefectivo` nuevo. `regfacvtapub_v2_c` no se tocó.
- **06/11/2026:** el aviso muestra el ahorro y "TOTAL A PAGAR EN EFECTIVO" en 36 puntos, para que el operador lo diga en esa misma venta.
  - `pidoefectivo`: `Init` recibe `tnAhorro, tnTotal`; nuevos `Lbltotaltit` y `Lbltotal`; alto de 270 a 340; importes con separador de miles. Conserva el fondo `Image1` / `fondoabm.jpg` que agregó Marcos.
  - `regfacvtapub`: solo cambia la llamada: `DO FORM pidoefectivo WITH lnAhorro,thisform._txttotal.Value TO llAceptoEfectivo`.

### Respaldos (en `FORMS\venta`)
- `respaldo_20261105_efectivo`: `regfacvtapub` anterior al descuento por efectivo. Para quitar la función completa, restaurarlo; `pidoefectivo` queda sin uso.
- `respaldo_20261106_total`: `regfacvtapub` y `pidoefectivo` anteriores al total grande.
- Restaurar con VFP cerrado o con los formularios sin abrir: VFP los bloquea.

### Método de edición
- Los SCX se editan convirtiéndolos a texto con FoxBin2Prg, modificando el `.sc2`, regenerando y compilando en una copia. Después se compara el texto para confirmar que cambió solo lo previsto.
- Partir siempre de la versión instalada y comparar su hash antes de copiar: Marcos también edita estos formularios a mano.
