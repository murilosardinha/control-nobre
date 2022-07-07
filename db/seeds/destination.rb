

# p=Product.find_by(name: 'ABRAÇADEIRA NYLON 300MM x 3,6MM VERMELHA')

# sales = Sale.includes(:products).where(products: {id: p.id})
# sales.update(destination_id: )