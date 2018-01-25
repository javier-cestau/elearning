class ReproveCourseJob < ApplicationJob
  queue_as :default

  def perform(*args)


    Course.all.each do |c|
      do_courses = DoCourse.where(enroll: 1, course_id: c.id, finished_at: nil)
      do_courses.each do |do_course|
        unless c.deadline_course.nil?
           if Date.today > c.deadline_course
                do_course.failed = 1
                do_course.finished_at = c.deadline_course
                do_course.save
           end

           if c.start_date == c.deadline_course
              if c.deadline_course == Date.today
                message = "El curso #{c.name} inicia y finaliza hoy"
              end
           else
             if c.deadline_course == Date.today
               message = "El curso #{c.name} finaliza hoy"
             else
               if c.deadline_course < Date.today
                 message = "El curso #{c.name} ya finalizó"
               end
             end
           end

            notification = Notification.new(user_id: do_course.user.id ,message: "#{message}", url:"/courses/#{c.id}", date: DateTime.now.localtime("-04:00"))
            notification.save!
            ActionCable.server.broadcast "notification_channel_#{do_course.user.id}",  notification: notification

        else

          if c.start_date == Date.today
            notification = Notification.new(user_id: do_course.user.id ,message: "El curso #{c.name} inicia hoy", url:"/courses/#{c.id}", date: DateTime.now.localtime("-04:00"))
            notification.save!
            ActionCable.server.broadcast "notification_channel_#{do_course.user.id}",  notification: notification
          end
        end
      end
    end

    # u = User.where(email: "javier.cestau1209@gmail.com").last
    # u.name = Time.now
    # u.save
    reschedule_job
  end

  def reschedule_job
    ReproveCourseJob.set(wait_until: Date.tomorrow.noon).perform_later()
  end
end
