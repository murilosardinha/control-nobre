filial = Filial.find_or_create_by(name: 'Escritorio', address: 'Santarém', category: 1)

# PRODUCTS
array = [
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "MASCARA PFF2 COM FILTRO",
  "LUVA MISTA DE LÁTEX PRETA",
  "LUVA MISTA DE LÁTEX PRETA",
  "LUVA MISTA DE LÁTEX PRETA",
  "LUVA MISTA DE LÁTEX PRETA",
  "LUVA MISTA DE LÁTEX PRETA",
  "LUVA DE RASPA P/ SOLDAGEM CANO CURTO",
  "LUVA DE RASPA P/ SOLDAGEM CANO CURTO",
  "LUVA DE RASPA P/ SOLDAGEM CANO CURTO",
  "LUVA DE RASPA P/ SOLDAGEM CANO CURTO",
  "LUVA DE RASPA P/ SOLDAGEM CANO LONGO",
  "LUVA DE RASPA P/ SOLDAGEM CANO LONGO",
  "LUVA DE RASPA P/ SOLDAGEM CANO LONGO",
  "LUVA 100% LATEX CANO LONGO",
  "LUVA 100% LATEX CANO LONGO",
  "LUVA 100% LATEX CANO CURTO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS LEOPARDO ESCURO",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "ÓCULOS ÁGUIA INCOLOR",
  "LENTE DE SOLDA",
  "LENTE DE SOLDA",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "PROTETOR AURICULAR WURTH",
  "ABAFADOR DE RUÍDOS",
  "KIT REPOSIÇÃO DO ABAFADOR DE RUIDOS",
  "BOTA BRACOL N.40",
  "BOTA BRACOL N.40",
  "BOTA BRACOL N.40",
  "BOTA BRACOL N.40",
  "BOTA BRACOL N.40",
]

array.tally.each do |k, v|
  k = k.squish!
  p = { name: k, quantity: v, filial_id: filial.id, category: :epi}
  Product.create(p)
end

# DESTINATIONS
destinations = [
  "EDICLEI",
  "JORQUEAN",
  "LOMBARDI",
  "LUCAS",
  "LUCAS",
  "LUCAS",
  "LUCAS",
  "MAMILA",
  "MARCELO",
  "ROBSON",
]

destinations.uniq.each do |name|
  k = name.squish!
  p = { name: k, filial_id: filial.id}
  Destination.create(p)
end


# SALES
sales = [
  { name: "LUVA MISTA DE LÁTEX PRETA", destination: "EDICLEI", created_at: '27/04/2022', obs: "Entregue por: VITOR"},
  { name: "LUVA DE RASPA P/ SOLDAGEM CANO CURTO", destination: "JORQUEAN", created_at: '06/05/2022', obs: "Entregue por: CAROL"},
  { name: "LUVA MISTA DE LÁTEX PRETA", destination: "LOMBARDI", created_at: '27/04/2022', obs: "Entregue por: CAROL"},
  { name: "MASCARA PFF2 COM FILTRO", destination: "LUCAS", created_at: '27/04/2022', obs: "Entregue por: VITOR"},
  { name: "MASCARA PFF2 COM FILTRO", destination: "LUCAS", created_at: '30/04/2022', obs: "Entregue por: VINICIUS"},
  { name: "MASCARA PFF2 COM FILTRO", destination: "LUCAS", created_at: '05/05/2022', obs: "Entregue por: VITOR"},
  { name: "ÓCULOS ÁGUIA INCOLOR", destination: "LUCAS", created_at: '05/05/2022', obs: "Entregue por: VITOR"},
  { name: "MASCARA PFF2 COM FILTRO", destination: "MAMILA", created_at: '30/04/2022', obs: "Entregue por: CAROLINY"},
  { name: "ÓCULOS LEOPARDO ESCURO", destination: "MARCELO", created_at: '19/04/2022', obs: "Entregue por: EDICLEI"},
  { name: "MASCARA PFF2 COM FILTRO", destination: "ROBSON", created_at: '07/05/2022', obs: "Entregue por: VINICIUS"},
]

sales.each do |item|
  destination = filial.destinations.find_by(name: item[:destination].squish!)
  product = filial.products.find_by(name: item[:name].squish!)

  if product.blank?
    k = item[:name].squish!
    p = { name: k, quantity: 1, filial_id: filial.id, category: :epi}
    product = Product.create(p)
  end

  sale = filial.sales.build(
    destination_id: destination.id,
    date: item[:created_at],
    obs: item[:obs]
  )
  
  product = filial.products.find_by(id: product.id)
  
  # remove from stock
  result = product.decrease_quantity(1)
  next unless result
  
  # add in order
  sale.sale_products.build(
    product_id: product.id,
    quantity: 1,
    prices: Product.find_prices(product.code, 1)
  )

  sale.done!
  sale.sale_products.map(&:done!)
end