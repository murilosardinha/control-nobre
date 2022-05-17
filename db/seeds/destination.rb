filial = Filial.find_or_create_by(name: 'Escritorio', address: 'Santarém', category: 1)
destination_names = filial.destinations.map(&:name).uniq

destination_names.each do |d_name|
  d = filial.destinations.where(name: d_name).order(:operador).first
  Sale.includes(:destination).where(destinations: {name: d_name}).update_all(destination_id: d.id)
  filial.destinations.where(name: d_name).where.not(id: d.id).destroy_all
end

