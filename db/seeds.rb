# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# ── Tenants ───────────────────────────────────────────────────────────────────
iwf = Tenant.find_or_create_by!(subdomain: "iwf") do |t|
  t.name        = "IWF"
  t.plan        = "enterprise"
  t.active      = true
end
puts "✅ Tenant: #{iwf.name}"

# ── Departamentos ─────────────────────────────────────────────────────────────
ActsAsTenant.without_tenant do
  dept_ti   = Department.find_or_create_by!(name: "TI",           tenant: iwf)
  dept_rrhh = Department.find_or_create_by!(name: "RRHH",         tenant: iwf)
  dept_ops  = Department.find_or_create_by!(name: "Operaciones",  tenant: iwf)
  puts "✅ Departamentos creados"

  # ── Super Admin ─────────────────────────────────────────────────────────────
  super_admin = User.find_or_initialize_by(email: "superadmin@iwfhub.com")
  if super_admin.new_record?
    super_admin.assign_attributes(
      name:                  "Super Admin",
      full_name:             "Super Administrador Hub",
      role:                  "super_admin",
      password:              "CambiaEstoClave2026!",
      password_confirmation: "CambiaEstoClave2026!"
    )
    super_admin.save!
    puts "✅ Super Admin creado: #{super_admin.email}"
  else
    puts "✅ Super Admin ya existe: #{super_admin.email}"
  end

  # ── Admin IWF ────────────────────────────────────────────────────────────────
  admin = User.find_or_initialize_by(email: "admin@interworldfreight.com")
  if admin.new_record?
    admin.assign_attributes(
      name:                  "Admin IWF",
      full_name:             "Administrador IWF",
      role:                  "admin",
      tenant:                iwf,
      department:            dept_ti,
      password:              "CambiaEstoClave2026!",
      password_confirmation: "CambiaEstoClave2026!"
    )
    admin.save!
    puts "✅ Admin creado: #{admin.email}"
  else
    puts "✅ Admin ya existe: #{admin.email}"
  end

  # ── Usuario RRHH ─────────────────────────────────────────────────────────────
  rrhh = User.find_or_initialize_by(email: "rrhh@interworldfreight.com")
  if rrhh.new_record?
    rrhh.assign_attributes(
      name:                  "RRHH IWF",
      full_name:             "Recursos Humanos IWF",
      role:                  "rrhh",
      tenant:                iwf,
      department:            dept_rrhh,
      password:              "CambiaEstoClave2026!",
      password_confirmation: "CambiaEstoClave2026!"
    )
    rrhh.save!
    puts "✅ RRHH creado: #{rrhh.email}"
  else
    puts "✅ RRHH ya existe: #{rrhh.email}"
  end

  # ── Usuario empleado ──────────────────────────────────────────────────────────
  employee = User.find_or_initialize_by(email: "empleado@interworldfreight.com")
  if employee.new_record?
    employee.assign_attributes(
      name:                  "Empleado Demo",
      full_name:             "Empleado de Prueba",
      role:                  "employee",
      tenant:                iwf,
      department:            dept_ops,
      password:              "CambiaEstoClave2026!",
      password_confirmation: "CambiaEstoClave2026!"
    )
    employee.save!
    puts "✅ Empleado creado: #{employee.email}"
  else
    puts "✅ Empleado ya existe: #{employee.email}"
  end
end

# ── Permisos por defecto ──────────────────────────────────────────────────────
defaults = {
  "rrhh" => {
  "Equipment"         => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "User"              => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "Department"        => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "Location"          => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "Vendor"            => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "EquipmentCategory" => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "Assignment"        => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "EquipmentEvent"    => { index: true,  show: true,  create: true,  update: false, destroy: false },
  "Extension"         => { index: true,  show: true,  create: true,  update: true,  destroy: false },
  "OnboardingRequest" => { index: true,  show: true,  create: true,  update: true,  destroy: false }
},
"consulta" => {
  "Equipment"         => { index: true,  show: true,  create: false, update: false, destroy: false },
  "User"              => { index: true,  show: true,  create: false, update: false, destroy: false },
  "Department"        => { index: true,  show: true,  create: false, update: false, destroy: false },
  "Location"          => { index: true,  show: true,  create: false, update: false, destroy: false },
  "Vendor"            => { index: true,  show: true,  create: false, update: false, destroy: false },
  "EquipmentCategory" => { index: true,  show: true,  create: false, update: false, destroy: false },
  "Assignment"        => { index: true,  show: true,  create: false, update: false, destroy: false },
  "EquipmentEvent"    => { index: true,  show: true,  create: false, update: false, destroy: false },
  "Extension"         => { index: true,  show: false, create: false, update: false, destroy: false },
  "OnboardingRequest" => { index: true,  show: true,  create: false, update: false, destroy: false }
},
"employee" => {
  "Equipment"         => { index: false, show: true,  create: false, update: false, destroy: false },
  "User"              => { index: false, show: true,  create: false, update: false, destroy: false },
  "Department"        => { index: false, show: false, create: false, update: false, destroy: false },
  "Location"          => { index: false, show: false, create: false, update: false, destroy: false },
  "Vendor"            => { index: false, show: false, create: false, update: false, destroy: false },
  "EquipmentCategory" => { index: false, show: false, create: false, update: false, destroy: false },
  "Assignment"        => { index: false, show: true,  create: false, update: false, destroy: false },
  "EquipmentEvent"    => { index: false, show: false, create: false, update: false, destroy: false },
  "Extension"         => { index: false, show: false, create: false, update: false, destroy: false },
  "OnboardingRequest" => { index: false, show: true,  create: false, update: false, destroy: false }
}
  }
}

ActsAsTenant.without_tenant do
  defaults.each do |role, resources|
    resources.each do |resource, perms|
      p = Permission.find_or_initialize_by(role: role, resource: resource)
      p.assign_attributes(
        can_index:   perms[:index],
        can_show:    perms[:show],
        can_create:  perms[:create],
        can_update:  perms[:update],
        can_destroy: perms[:destroy]
      )
      p.save!
      puts "✅ Permiso: #{role} / #{resource}"
    end
  end
end

puts "\n🎉 Seeds completados exitosamente"