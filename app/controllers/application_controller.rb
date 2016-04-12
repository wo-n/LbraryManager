class ApplicationController < ActionController::Base
  protect_from_forgery

	before_filter :authorize

	class Forbidden < StandardError; end

	private
	def authorize
		@current_member = Member.find_by_id(session[:member_id])
		session.delete(:member_id) unless @current_member
	end

	def login_required
		raise Forbidden unless @current_member
	end

        def admin_check		#管理者かどうか
        	raise Forbidden if !@current_member.admin
        end

        def member_check	#自分以外の会員情報を見ようとしていないか
		raise Forbidden if !@current_member.admin && @member.id != @current_member.id 
        end
	
        
end
