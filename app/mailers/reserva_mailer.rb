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

  def cancelation_email
    @reserva = params[:reserva]
    mail(
      to: @reserva.email,
      subject: 'Cancelación de tu reserva en el Consultorio Psicológico'
    )
  end
end