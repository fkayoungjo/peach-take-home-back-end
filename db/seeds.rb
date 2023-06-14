require 'database_cleaner'
require 'csv'


class Seeds
  COLOR_SCALE_GREEN = '#DDF1A3'
  COLOR_SCALE_RED = '#FFC9C9'
  COLOR_SCALE_BLUE = '#B6E4FB'
  COLOR_SCALE_PINK = '#FFDAF9'
  COLOR_SCALE_BROWN = '#E5CBAF'
  COLOR_SCALE_YELLOW = '#FFECC6'

  CATEGORIES_MAP = [
    # INCOME
    ["Income", "🤑", COLOR_SCALE_GREEN],

    # SPENDING
    ["Food and Drink", "🍕", COLOR_SCALE_RED],
    ["Healthcare", "🏥", COLOR_SCALE_BROWN],
    ["Shops", "🛍", COLOR_SCALE_BLUE],
    ["Subscription Service", "📺", COLOR_SCALE_PINK],
    ["Travel", "✈️", COLOR_SCALE_YELLOW],
  ]

  MERCHANTS  = %w[Uber United Chiptole Payroll Amazon TurboTax BlueCross AMC Netflix Hulu]

  def update
      clean_db
      create_categories
      create_merchants
      create_transactions
      Rails.logger.info('Database is seeded')
  end

  private

  def clean_db
    DatabaseCleaner.clean_with :truncation
    Rails.logger.info('Database is cleaned')
  end

  def create_categories
    CATEGORIES_MAP.each do |c|
      name = c[0]
      emoji = c[1]
      color = c[2]

      Category.create(
        name: name,
        emoji: emoji,
        color: color,
      )
    end

    Rails.logger.info('Added Categories')
  end

  def create_merchants
    MERCHANTS.each do |m|
      Merchant.create(
        name: m,
      )
    end

    Rails.logger.info('Added Merchants')
  end


  DATA = [
    {
      "Transaction Name" => "Uber",
      "Merchant" => "Uber",
      "Amount" => 45.12,
      "Date" => "5/29/2023",
      "Category" => "Shops"
    },
    {
      "Transaction Name" => "SFO to JFK",
      "Merchant" => "United",
      "Amount" => 129.97,
      "Date" => "5/29/2023",
      "Category" => "Travel"
    },
    {
    "Transaction Name" => "Hulu",
    "Merchant" => "Hulu",
    "Amount" => 6.99,
    "Date" => "5/28/2023",
    "Category" => "Shops"
  },
  {
    "Transaction Name" => "Chiptole",
    "Merchant" => "Chiptole",
    "Amount" => 12.88,
    "Date" => "5/28/2023",
    "Category" => "Shops"
  },
  {
    "Transaction Name" => "Direct Deposit",
    "Merchant" => "Payroll",
    "Amount" => -2100.54,
    "Date" => "5/28/2023",
    "Category" => "Shops"
  },
  {
    "Transaction Name" => "Amazon",
    "Merchant" => "Amazon",
    "Amount" => 70.24,
    "Date" => "5/27/2023",
    "Category" => "Shops"
  },
  {
    "Transaction Name" => "Taxes 2022",
    "Merchant" => "TurboTax",
    "Amount" => 110.0,
    "Date" => "5/27/2023",
    "Category" => "Shops"
  },
  {
    "Transaction Name" => "Dr. Seuss",
    "Merchant" => "BlueCross",
    "Amount" => 55.23,
    "Date" => "5/27/2023",
    "Category" => "Shops"
  },
  {
    "Transaction Name" => "Fast X",
    "Merchant" => "AMC",
    "Amount" => 25.99,
    "Date" => "5/26/2023",
    "Category" => "Shops"
  },
  {
    "Transaction Name" => "Netflix",
    "Merchant" => "Netflix",
    "Amount" => 9.99,
    "Date" => "5/25/2023",
    "Category" => "Shops"
  },
  ]


  
  def create_transactions

  DATA.each do |row|
    Transaction.create!(
      transaction_name: row["Transaction Name"],
      merchant: Merchant.find_by(name: row['Merchant']),
      amount: row['Amount'].to_f,
      date: Date.strptime(row['Date'], '%m/%d/%Y'),
      category: Category.find_by(name: row['Category'])
    )
  end
end
  
end

Seeds.new.update
