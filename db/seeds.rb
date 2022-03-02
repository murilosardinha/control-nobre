filial = Filial.find_or_create_by(name: 'Escritorio')

User.find_or_create_by(name: 'Admin', email: 'admin@gmail.com', filial: filial, role: 1) do |u|
  u.password = '12345678'
  u.save
end