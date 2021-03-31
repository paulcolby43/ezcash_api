namespace :tud_socketing do
  desc "TODO"
  task start: :environment do
    require 'socket'
    puts "Started TCP Server"
    server = TCPServer.new 3334 # Server bound to port 3334
    loop do
      Thread.start(server.accept) do |client|
        p "Inside Task"
        string = client.recv(1000).chomp ## Request Data received at the socket port
        result = string.downcase
        partitioned_string = result.partition(' ') # Split on the first space after the command
        command = partitioned_string.first
        variables = partitioned_string.last.delete("!")
        params = variables.split(/=| /).each_slice(2).with_object({}) { |(k,v),h| h[k]=v }
        amount = params['amount'].to_f
        payment_nbr = params['payment_nbr']
        date = "#{params['date']} 00:00:00"
        
        if command == 'encode'
          date = params[:date].blank? ? Date.today.to_s : params[:date]
          barcode = ('%010d' % rand(0..9999999999))
          @card = Card.new(card_amt: amount, avail_amt: amount, card_nbr: payment_nbr, receipt_nbr: payment_nbr, issued_date: date, 
            last_activity_date: date, card_status: 'AC', bank_id_nbr: 111101, barcodeHash: barcode)
          if @card.save
            client.puts "SUCCESS #{barcode}"
          else
            client.puts "FAILED"
          end
        elsif command == 'void'
          unless @card.blank?
            @card = Card.where(card_amt: amount, card_nbr: payment_nbr, issued_date: date).first
            if @card.avail_amt.zero?
              # Card was already paid
              client.puts "REJECTED"
            elsif @card.avail_amt == @card.card_amt
              # Card has not been paid yet
              @card.card_status = 'VD'
              if @card.save
                client.puts  "SUCCESS"
              else
                client.puts "FAILED"
              end
            else
              original_amount = @card.card_amt
              available_amount = @card.avail_amt
              paid_amount = original_amount - available_amount
              @card.card_status = 'VD'
              if @card.save
                client.puts "PARTIALPAY #{paid_amount} of #{original_amount}"
              else
                client.puts "FAILED"
              end
            end
          else
            client.puts "FAILED payment_nbr=#{params['payment_nbr']} amount=#{params['amount']} date=#{params['date']}"
          end
        elsif command == 'inquire'
          @card = Card.where(card_amt: amount, card_nbr: payment_nbr, issued_date: date).first
          unless @card.blank?
            client.puts "payment_nbr=#{payment_nbr}barcode=#{@card.barcodeHash}initial_amt=#{@card.card_amt}avail_amt=#{@card.avail_amt}card_status=#{@card.card_status}"
          else
            client.puts "FAILED payment_nbr=#{params['payment_nbr']} amount=#{params['amount']} date=#{params['date']}"
          end
        end
        p 'Bye'
        client.close
      end
    end
  end

end


