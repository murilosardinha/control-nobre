filial = Filial.find_or_create_by(name: 'Escritorio', address: 'Santarém', category: 1)
destination_names = filial.destinations.map(&:name).uniq

destination_names.each do |d_name|
  d = filial.destinations.where(name: d_name).order(:operador).first
  Sale.includes(:destination).where(destinations: {name: d_name}).update_all(destination_id: d.id)
  filial.destinations.where(name: d_name).where.not(id: d.id).destroy_all
end

Destination.all.map{|d| d.update(name: d.name.strip)}


d1=Destination.find_by(name: 'TRATOR CBJ')
d2=Destination.find_by(name: 'TRATOR D6N CBJ 01')
d3=Destination.find_by(name: 'D6N CBJ Nº16')

Sale.where(destination_id: d1.id).update_all(destination_id: d3.id)
Sale.where(destination_id: d2.id).update_all(destination_id: d3.id)
d1.destroy
d2.destroy

d1=Destination.find_by(name: 'TRATOR D6N JLE')
d2=Destination.find_by(name: 'D6N JLE Nº17')
Sale.where(destination_id: d1.id).update_all(destination_id: d2.id)
d1.destroy
