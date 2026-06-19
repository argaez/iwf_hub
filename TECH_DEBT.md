# Deuda técnica — IWF Hub

## Avo Sidebar override (sin licencia Pro)

**Fecha:** Junio 2026
**Archivos afectados:**
- `app/components/avo/sidebar_component.html.erb`
- `app/views/avo/partials/_sidebar_extra.html.erb`

**Qué se hizo:**
Se sobreescribió el componente `Avo::SidebarComponent` para tener un
menú navegable agrupado por secciones, ya que `config.main_menu` es
una función exclusiva de Avo Pro.

**Riesgo:**
- Si Avo actualiza la estructura interna de su `SidebarComponent`,
  nuestro override puede romperse silenciosamente al actualizar la gem.
- Cada nuevo recurso (modelo) debe agregarse manualmente en
  `_sidebar_extra.html.erb` — no es automático como en Avo nativo.

**Decisión:**
Aceptado como solución temporal. Avo es solo herramienta interna de
administración (uso de admin/super_admin), no requiere pulido visual
extremo. El esfuerzo de diseño se invierte en el frontend React, que
es lo que verán los empleados.

**Revisar cuando:**
- Se actualice la gem `avo` a una versión mayor
- Se considere comprar licencia Avo Pro
- Aparezcan bugs raros en el sidebar después de un `bundle update`