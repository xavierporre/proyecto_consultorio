class ReservaMailer < ApplicationMailer

  default from: 'xaporre@miuandes.cl' 
  
  def confirmation_email
    
    @reserva = params[:reserva]
    @cita = @reserva.cita_disponible
    
    mail(
      to: @reserva.email,
      subject: 'Confirmación de su reserva'
    )
  end
end