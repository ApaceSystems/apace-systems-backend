# frozen_string_literal: true

Category.destroy_all
Product.destroy_all

# Create categories
cop = Category.create!(name: 'Car Operating Panels (COP)', description: 'Car operating panels for elevators.')
lop = Category.create!(name: 'Landing Operating Panels (LOP)', description: 'Landing operating panels for elevators.')
other = Category.create!(name: 'Other Elevator Parts', description: 'Miscellaneous elevator parts.')

# Create products
Product.create!(
  name: 'Wall Mount Type Cop With E.light',
  description: 'Wall mount type car operating panel available in S.S. 304 hairline finish, mirror finish, and designer finish.',
  price: 1000.00,
  category: cop,
  features: {
    display_type: 'LCD',
    voltage: '12V DC',
    additional_features: 'Emergency light, emergency alarm, intercom'
  }
)

Product.create!(
  name: 'LOP (Landing Operating Panel)',
  description: 'LOP available in S.S. 304 hairline finish and mirror finish with different types of display.',
  price: 500.00,
  category: lop,
  features: {
    display_type: 'Seven segment, scrolling, LCD',
    voltage: '12V DC, 24V DC'
  }
)

Product.create!(
  name: 'Elevator Parts',
  description: 'COP with emergency light, emergency alarm with battery backup, LED colors - red, blue, green, orange, 12/24 VDC voltage, LOP - scrolling display, LCD display.',
  price: 1500.00,
  category: other,
  features: {
    display_type: 'Scrolling, LCD, Seven segment',
    voltage: '12V DC, 24V DC',
    additional_features: 'Emergency light, emergency alarm, intercom'
  }
)
