class Admin::ReportsController < ApplicationController
  def enroll_by_week
      error = false
      @year = Time.current.year

      unless params[:year].nil?
        @year = params[:year].to_i
      end

      @json_year = Hash.new

      @json_year["data"] = {

          "year": []
      }

      @json_year["data"][:year].push({


          "#{@year}":{

              "Enero": 1,
              "Febrero": 2 ,
              "Marzo": 3,
              "Abril":4,
              "Mayo":5,
              "Junio":6,
              "Julio":7,
              "Agosto":8,
              "Septiembre":9,
              "Octubre":10,
              "Noviembre":11,
              "Diciembre":12

          }
      })



      @json_year["data"][:year][0][:"#{@year.to_s}"].each do |month|

          total_weeks = Date.new(@year,month[1],1).total_weeks


          week_hash = Hash.new

          for i in 1..total_weeks do
             week_hash[i] = 0
           end

            @json_year["data"][:year][0][:"#{@year}"][:"#{month[0]}"] = week_hash


      end


      if params[:course].nil?
        if params[:department].nil?
          @inscriptions = DoCourse.where('extract(year  from created_at) = ?',@year).order("created_at ASC")

                @inscriptions.each do |inscription|
                  year = inscription.created_at.year
                  month_i = inscription.created_at.month
                  month_s = localize inscription.created_at, format: "%B"
                  day = inscription.created_at.day
                  week = Date.new(year,month_i,day).week_of_month

                  @json_year["data"][:year][0][:"#{year}"][:"#{month_s}"][week] += 1
                end
        else
           @inscriptions = DoCourse.joins(:user).where( users: {department_id: params[:department]},created_at: Date.new(@year,1,1)..Date.new(@year,12,31)).order("created_at ASC")

          @inscriptions.each do |inscription|
            year = inscription.created_at.year
            month_i = inscription.created_at.month
            month_s = localize inscription.created_at, format: "%B"
            day = inscription.created_at.day
            week = Date.new(year,month_i,day).week_of_month

            @json_year["data"][:year][0][:"#{year}"][:"#{month_s}"][week] += 1

          end
        end
      else
        if params[:department].nil?
          @inscriptions = DoCourse.where('extract(year  from created_at) = ? AND course_id = ?',@year,params[:course]).order("created_at ASC")

                @inscriptions.each do |inscription|
                  year = inscription.created_at.year
                  month_i = inscription.created_at.month
                  month_s = localize inscription.created_at, format: "%B"
                  day = inscription.created_at.day
                  week = Date.new(year,month_i,day).week_of_month

                  @json_year["data"][:year][0][:"#{year}"][:"#{month_s}"][week] += 1
                end
        else
           @inscriptions = DoCourse.joins(:user).where( users: {department_id: params[:department]},created_at: Date.new(@year,1,1)..Date.new(@year,12,31),course_id: params[:course]).order("created_at ASC")

          @inscriptions.each do |inscription|
            year = inscription.created_at.year
            month_i = inscription.created_at.month
            month_s = localize inscription.created_at, format: "%B"
            day = inscription.created_at.day
            week = Date.new(year,month_i,day).week_of_month

            @json_year["data"][:year][0][:"#{year}"][:"#{month_s}"][week] += 1

          end
        end
      end


  end

  def enroll_by_day
    error = false

    if params[:year].nil?
      @year = Time.current.year
    else
      @year = params[:year].to_i
    end


    @json_year = Hash.new
      @json_year["data"] = {

          "year": []
      }


      @json_year["data"][:year].push({


          "#{@year}":{

              "Enero": 1,
              "Febrero": 2 ,
              "Marzo": 3,
              "Abril":4,
              "Mayo":5,
              "Junio":6,
              "Julio":7,
              "Agosto":8,
              "Septiembre":9,
              "Octubre":10,
              "Noviembre":11,
              "Diciembre":12

          }
      })
      @json_year["data"][:year][0][:"#{@year.to_s}"].each do |month|

          total_days = Date.new(@year,month[1],1).last_day_of_month

          day_hash = Hash.new

          for i in 1..total_days do
             day_hash[i] = 0
           end

            @json_year["data"][:year][0][:"#{@year}"][:"#{month[0]}"] = day_hash


      end

      if params[:course].nil?
        if params[:department].nil?
          @inscriptions = DoCourse.where('extract(year  from created_at) = ?',@year).order("created_at ASC")

                @inscriptions.each do |inscription|
                  year = inscription.created_at.year
                  month_i = inscription.created_at.month
                  month_s = localize inscription.created_at, format: "%B"
                  day = inscription.created_at.day

                   @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"][day] += 1
                end
        else
          @inscriptions = DoCourse.joins(:user).where( users: {department_id: params[:department]},created_at: Date.new(@year,1,1)..Date.new(@year,12,31)).order("created_at ASC")

          @inscriptions.each do |inscription|
            year = inscription["created_at"].year
            month_i = inscription["created_at"].month
            day = inscription["created_at"].day
            month_s = localize inscription["created_at"].to_date, format: "%B"

             @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"][day.to_i] += 1
          end
        end
      else
        if params[:department].nil?
          @inscriptions = DoCourse.where('extract(year  from created_at) = ? AND  course_id = ?',@year,params[:course]).order("created_at ASC")

                @inscriptions.each do |inscription|
                  year = inscription.created_at.year
                  month_i = inscription.created_at.month
                  month_s = localize inscription.created_at, format: "%B"
                  day = inscription.created_at.day

                   @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"][day] += 1
                end
        else
          @inscriptions = DoCourse.joins(:user).where( users: {department_id: params[:department]},created_at: Date.new(@year,1,1)..Date.new(@year,12,31),course_id: params[:course]).order("created_at ASC")

          @inscriptions.each do |inscription|
            year = inscription["created_at"].year
            month_i = inscription["created_at"].month
            day = inscription["created_at"].day
            month_s = localize inscription["created_at"].to_date, format: "%B"

             @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"][day.to_i] += 1
          end
        end
      end

   end

   def enroll_by_month
     error = false

     if params[:year].nil?
       @year = Time.current.year
     else
       @year = params[:year].to_i
     end


     @json_year = Hash.new
       @json_year["data"] = {

           "year": []
       }


       @json_year["data"][:year].push({


           "#{@year}":{

               "Enero": 0,
               "Febrero": 0 ,
               "Marzo": 0,
               "Abril":0,
               "Mayo":0,
               "Junio":0,
               "Julio":0,
               "Agosto":0,
               "Septiembre":0,
               "Octubre":0,
               "Noviembre":0,
               "Diciembre":0

           }
       })

       if params[:course].nil?
         if params[:department].nil?
           @inscriptions = DoCourse.where('extract(year  from created_at) = ?',@year).order("created_at ASC")

                 @inscriptions.each do |inscription|
                   year = inscription.created_at.year
                   month_i = inscription.created_at.month
                   month_s = localize inscription.created_at, format: "%B"

                    @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"] += 1
                 end
         else
           @inscriptions = DoCourse.joins(:user).where( users: {department_id: params[:department]},created_at: Date.new(@year,1,1)..Date.new(@year,12,31)).order("created_at ASC")

           @inscriptions.each do |inscription|
             year = inscription["created_at"].year
             month_i = inscription["created_at"].month
             month_s = localize inscription["created_at"].to_date, format: "%B"

              @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"] += 1
           end
         end
       else

           if params[:department].nil?
             @inscriptions = DoCourse.where('extract(year  from created_at) = ? AND course_id = ?',@year, params[:course]).order("created_at ASC")

                   @inscriptions.each do |inscription|
                     year = inscription.created_at.year
                     month_i = inscription.created_at.month
                     month_s = localize inscription.created_at, format: "%B"

                      @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"] += 1
                   end
           else
             @inscriptions = DoCourse.joins(:user).where( users: {department_id: params[:department]},created_at: Date.new(@year,1,1)..Date.new(@year,12,31),course_id: params[:course]).order("created_at ASC")

             @inscriptions.each do |inscription|
               year = inscription["created_at"].year
               month_i = inscription["created_at"].month
               month_s = localize inscription["created_at"].to_date, format: "%B"

                @json_year["data"][:year][0][:"#{@year}"][:"#{month_s}"] += 1
             end
           end
       end

   end
end
