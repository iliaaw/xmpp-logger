class App < Sinatra::Base
  get '/' do
    sql_select = 'distinct extract(year from created_at at time zone \'UTC +4\') as year'
    sql_order = 'year desc'
    @messages = Message.all(:select => sql_select, :order => sql_order)
    if @messages.blank?
      raise ActiveRecord::RecordNotFound
    end
    erb :index
  end

  get %r{^/([\d]+)/?$} do |year|
    sql_where = 'extract(year from created_at at time zone \'UTC +4\') = ?'
    sql_select = 'distinct extract(month from created_at at time zone \'UTC +4\') as month'
    sql_order = 'month desc'
    @year = year
    @messages = Message.where(sql_where, year).all(:select => sql_select, :order => sql_order)
    if @messages.blank?
      raise ActiveRecord::RecordNotFound
    end
    erb :by_year
  end

  get %r{^/([\d]+)/([\d]+)/?$} do |year, month|
    sql_where = 'extract(year from created_at at time zone \'UTC +4\') = ?'
    sql_where += 'and extract(month from created_at at time zone \'UTC +4\') = ?'
    sql_select = 'distinct extract(day from created_at at time zone \'UTC +4\') as day'
    sql_order = 'day desc'
    @year = year
    @month = month
    @messages = Message.where(sql_where, year, month).all(:select => sql_select, :order => sql_order)
    if @messages.blank?
      raise ActiveRecord::RecordNotFound
    end
    erb :by_month
  end

  get %r{^/([\d]+)/([\d]+)/([\d]+)/?$} do |year, month, day| 
    sql_where = 'extract(year from created_at at time zone \'UTC +4\') = ?'
    sql_where += 'and extract(month from created_at at time zone \'UTC +4\') = ?'
    sql_where += 'and extract(day from created_at at time zone \'UTC +4\') = ?'
    sql_order = 'created_at asc'
    @year = year
    @month = month
    @day = day
    @messages = Message.where(sql_where, year, month, day).all(:order => sql_order)
    if @messages.blank?
      raise ActiveRecord::RecordNotFound
    end
    erb :by_day
  end
end