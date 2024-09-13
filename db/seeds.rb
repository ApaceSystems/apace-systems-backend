# frozen_string_literal: true

Category.destroy_all
Product.destroy_all

# Create categories
cop = Category.create!(name: 'Car Operating Panels (COP)', description: 'Car operating panels for elevators.')
lop = Category.create!(name: 'Landing Operating Panels (LOP)', description: 'Landing operating panels for elevators.')
elevator_push_buttons = Category.create!(name: 'Elevator Push Buttons', description: 'Push Buttons for elevators.')

# Create products
Product.find_or_create_by!(
  name: 'Wall Mount Type Cop With E.light',
  description: 'Wall mount type car operating panel available in S.S. 304 hairline finish, ' \
               'mirror finish, and designer finish.',
  price: 1000.00,
  category: cop,
  features: {
    display_type: '7-Segment',
    voltage: '12V DC',
    additional_features: 'Emergency light, Intercom'
  }
)

Product.create!(
  name: 'LOP (Landing Operating Panel)',
  description: 'LOP available in S.S. 304 hairline finish and mirror finish with different types of display.',
  price: 500.00,
  category: lop,
  features: {
    display_type: 'Dot-matrix',
    voltage: '12V DC, 24V DC'
  }
)

Product.find_or_create_by!(
  name: 'COP with emergency light',
  description: 'COP with emergency light, emergency light with battery backup, LED colors - red, blue, green, ' \
               'orange, 12/24 VDC voltage, LOP - scrolling display, 7-Segment display.',
  price: 1500.00,
  category: cop,
  features: {
    display_type: 'Dot-matrix, 7-Segment',
    voltage: '12V DC, 24V DC',
    additional_features: 'Emergency light, Intercom'
  }
)

Product.create!(
  name: 'Elevator Push Buttons',
  description: 'Elevator Push Buttons',
  price: 1500.00,
  category: elevator_push_buttons,
  features: {
    display_type: '7-Segment',
    voltage: '12V DC',
    additional_features: ['Emergency light', 'Intercom']
  }
)
