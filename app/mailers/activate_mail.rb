#encoding: utf-8
class ActivateMail < ActionMailer::Base
  default from: "PureWeber"

  def sent(user)
    @user = user
    @url  = "http://localhost:3000/users/?cad_id=#{@user.cad_id}&active_code=#{@user.active_code}"
    mail to: user.email, subject: "欢迎加入PureWeber2013 web开发课程"
  end
end
