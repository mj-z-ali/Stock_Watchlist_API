class StockController < ApplicationController 

	# Filter to prevent users from accessing routes without being logged
	before do

		if !session[:logged_in]
			halt 200, {
				success: false,

				message: "Access Denied: Please Login."
			}.to_json
		end	
	end

	# Routes

	# Index Route in Watchlist
	get '/' do
		user = User.find(session[:user_id])

		user_watchlist = user.stocks.map { |obj| obj[:ticker] }


		{
			success: true,
			message: "Found #{user_watchlist.length} stock(s) for #{user[:email]}.",
			stocks: user_watchlist
		}.to_json

	end

	# Add stock to user watchlist
	post '/:ticker' do
		user = User.find(session[:user_id])

		new_stock = user.stocks.create ticker:params[:ticker]

		{
			success: true,

			message: "Added new stock #{params[:ticker]} to watchlist.",

			stock: new_stock[:ticker]
		}.to_json


	end	



end	

