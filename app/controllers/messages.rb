class App < Sinatra::Base
  # GET /
  get '/', :auth => :user do
    sql_select = sql_extract('year')
    sql_order = 'year desc'

    @messages = Message.all(:select => sql_select, :order => sql_order)

    haml :'messages/years', :layout => :messages_layout
  end

  # GET /2013
  get %r{^/([\d]+)/?$}, :auth => :user do |year|
    sql_where = @@sql_where_years
    sql_select = sql_extract('month')
    sql_order = 'month desc'

    @year = year
    @messages = Message.where(sql_where, year).all(:select => sql_select, :order => sql_order)
    if @messages.blank?
      error 404
    end

    haml :'messages/months', :layout => :messages_layout
  end

  # GET /2013/05
  get %r{^/([\d]+)/([\d]+)/?$}, :auth => :user do |year, month|
    sql_where = @@sql_where_years + @@sql_where_months
    sql_select = sql_extract('day')
    sql_order = 'day desc'

    @year = year
    @month = month
    @messages = Message.where(sql_where, year, month).all(:select => sql_select, :order => sql_order)
    if @messages.blank?
      error 404
    end

    haml :'messages/days', :layout => :messages_layout
  end

  # GET /2013/05/09
  get %r{^/([\d]+)/([\d]+)/([\d]+)/?$}, :auth => :user do |year, month, day| 
    sql_where = @@sql_where_years + @@sql_where_months + @@sql_where_days
    sql_order = 'created_at asc'

    @year = year
    @month = month
    @day = day
    @messages = Message.where(sql_where, year, month, day).all(:order => sql_order)
    if @messages.blank?
      error 404
    end
    
    haml :'messages/messages', :layout => :messages_layout
  end

  @@sql_where_years = 'extract(year from created_at at time zone \'UTC\') = ?'
  @@sql_where_months = ' and extract(month from created_at at time zone \'UTC\') = ?'
  @@sql_where_days = ' and extract(day from created_at at time zone \'UTC\') = ?'

  private
  def sql_extract(field)
    "distinct extract(#{field} from created_at at time zone \'UTC\') as #{field}"
  end
end
