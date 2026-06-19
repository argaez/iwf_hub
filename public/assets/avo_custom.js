function hideAvoDefaults() {
  document.querySelectorAll('.avo-sidebar a').forEach(function(a) {
    if (a.textContent.trim() === 'Get started') a.style.display = 'none'
  })
  document.querySelectorAll('.avo-sidebar span').forEach(function(span) {
    if (span.textContent.trim() === 'Resources') {
      var el = span.parentElement && span.parentElement.parentElement && span.parentElement.parentElement.parentElement
      if (el) el.style.display = 'none'
    }
  })
}

function initAccordion() {
  var sidebar = document.querySelector('.avo-sidebar')
  if (!sidebar) return
  var groups = Array.from(sidebar.querySelectorAll('[data-controller="menu"]'))
  if (!groups.length || groups[0]._accordionReady) return

  var activeGroupIdx = -1
  groups.forEach(function(group, idx) {
    if (group.querySelector('a[aria-current="page"]')) {
      activeGroupIdx = idx
      group.classList.add('has-active')
    }
  })

  groups.forEach(function(group, idx) {
    group._accordionReady = true
    var header = group.querySelector('[data-action*="triggerCollapse"]')
    var items  = group.querySelector('[data-menu-target="items"]')
    var svg    = group.querySelector('[data-menu-target="svg"]')
    if (!header || !items) return

    header.removeAttribute('data-action')
    items.classList.remove('hidden')
    items.style.overflow = 'hidden'

    function openGroup(animated) {
      items.style.transition = animated ? 'height 0.22s ease, margin 0.2s ease' : 'none'
      items.style.margin = '2px 6px 4px'
      items.style.height = items.scrollHeight + 'px'
      if (svg) svg.style.transform = 'rotate(0deg)'
      group.classList.add('is-open')
      if (!animated) requestAnimationFrame(function() {
        items.style.transition = 'height 0.22s ease, margin 0.2s ease'
      })
    }
    function closeGroup(animated) {
      items.style.transition = animated ? 'height 0.22s ease, margin 0.2s ease' : 'none'
      items.style.height = '0px'
      items.style.margin = '0'
      if (svg) svg.style.transform = 'rotate(-90deg)'
      group.classList.remove('is-open')
      if (!animated) requestAnimationFrame(function() {
        items.style.transition = 'height 0.22s ease, margin 0.2s ease'
      })
    }

    if (activeGroupIdx >= 0 && idx === activeGroupIdx) openGroup(false)
    else closeGroup(false)

    header.addEventListener('click', function() {
      var isOpen = items.style.height !== '0px'
      if (isOpen) {
        closeGroup(true)
      } else {
        groups.forEach(function(other) {
          if (other === group) return
          var oi = other.querySelector('[data-menu-target="items"]')
          var os = other.querySelector('[data-menu-target="svg"]')
          if (oi) { oi.style.transition = 'height 0.22s ease, margin 0.2s ease'; oi.style.height = '0px'; oi.style.margin = '0' }
          if (os) os.style.transform = 'rotate(-90deg)'
          other.classList.remove('is-open')
        })
        openGroup(true)
      }
    })
  })
}

function initRipple() {
  var sidebar = document.querySelector('.avo-sidebar')
  if (!sidebar || sidebar._rippleReady) return
  sidebar._rippleReady = true
  sidebar.addEventListener('click', function(e) {
    var link = e.target.closest('a')
    if (!link || !sidebar.contains(link)) return
    var rect = link.getBoundingClientRect()
    var size = Math.max(rect.width, rect.height) * 2.5
    var wave = document.createElement('span')
    wave.classList.add('iwf-ripple-wave')
    wave.style.width  = size + 'px'
    wave.style.height = size + 'px'
    wave.style.top    = (e.clientY - rect.top  - size / 2) + 'px'
    wave.style.left   = (e.clientX - rect.left - size / 2) + 'px'
    link.appendChild(wave)
    setTimeout(function() { wave.remove() }, 1200)
  })
}

function initPriceFormat() {
  document.querySelectorAll('input[id*="purchase_price"], input[id*="price"], input[id*="cost"]').forEach(function(input) {
    if (input._priceReady) return
    input._priceReady = true
    input.addEventListener('input', function() {
      var cursor = input.selectionStart
      var old    = input.value
      var raw    = old.replace(/\./g, '').replace(/[^0-9]/g, '')
      var formatted = raw.replace(/\B(?=(\d{3})+(?!\d))/g, '.')
      if (formatted === old) return
      var dotsAntes = (old.substring(0, cursor).match(/\./g) || []).length
      var digitsAntes = cursor - dotsAntes
      input.value = formatted
      var newPos = 0, cnt = 0
      for (var i = 0; i < formatted.length; i++) {
        if (formatted[i] !== '.') cnt++
        if (cnt === digitsAntes) { newPos = i + 1; break }
      }
      if (cnt < digitsAntes) newPos = formatted.length
      input.setSelectionRange(newPos, newPos)
    })
    var form = input.closest('form')
    if (form && !form._priceSubmitReady) {
      form._priceSubmitReady = true
      form.addEventListener('submit', function() {
        form.querySelectorAll('input[id*="purchase_price"], input[id*="price"], input[id*="cost"]').forEach(function(i) {
          i.value = i.value.replace(/\./g, '')
        })
      })
    }
  })
}

function initAssignmentCascade() {
  var cat = document.getElementById('assignment_filter_category_id')
  var eq  = document.getElementById('assignment_equipment_id')
  if (!cat || !eq || eq._ready) return
  eq._ready = true
  function disableEq(msg) {
    eq.disabled = true; eq.style.opacity = '0.4'; eq.style.pointerEvents = 'none'
    eq.style.backgroundColor = '#f3f4f6'; eq.style.cursor = 'not-allowed'
    eq.innerHTML = '<option value="">' + (msg || 'Selecciona...') + '</option>'
  }
  function enableEq() {
    eq.disabled = false; eq.style.opacity = ''; eq.style.pointerEvents = ''
    eq.style.backgroundColor = ''; eq.style.cursor = ''
  }
  if (!eq.value) disableEq()
  cat.addEventListener('change', function() {
    var categoryId = cat.value
    if (!categoryId) { disableEq(); return }
    disableEq('Cargando...')
    fetch('/equipment_options?category_id=' + categoryId, { headers: { 'Accept': 'application/json' } })
      .then(function(r) { return r.json() })
      .then(function(items) {
        if (items.length === 0) {
          disableEq('No hay ' + cat.options[cat.selectedIndex].text.toLowerCase() + ' disponibles')
        } else {
          eq.innerHTML = '<option value="">Selecciona...</option>'
          items.forEach(function(item) {
            var opt = document.createElement('option')
            opt.value = item.id; opt.textContent = item.name
            eq.appendChild(opt)
          })
          enableEq()
        }
      })
      .catch(function() { disableEq() })
  })
}

function initLazyRows() {
  var rows = document.querySelectorAll('table tbody tr')
  if (!rows.length) return
  var observer = new IntersectionObserver(function(entries) {
    entries.forEach(function(entry) {
      if (entry.isIntersecting) {
        var row = entry.target
        var delay = parseFloat(row.dataset.iwfDelay || 0)
        row.style.animationDelay = delay + 's'
        row.classList.remove('iwf-row-hidden')
        row.classList.add('iwf-row-visible')
        observer.unobserve(row)
      }
    })
  }, { threshold: 0.05, rootMargin: '0px 0px 60px 0px' })
  rows.forEach(function(row, i) {
    row.classList.add('iwf-row-hidden')
    row.dataset.iwfDelay = Math.min(i * 0.04, 0.3).toFixed(2)
    observer.observe(row)
  })
}

function init() {
  hideAvoDefaults()
  initAccordion()
  initRipple()
  initPriceFormat()
  setTimeout(initAssignmentCascade, 80)
  setTimeout(initLazyRows, 30)
}

document.addEventListener('turbo:load',       init)
document.addEventListener('turbo:render',     init)
document.addEventListener('DOMContentLoaded', init)