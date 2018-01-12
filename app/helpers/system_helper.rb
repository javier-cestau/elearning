module SystemHelper
  def get_date_from_backup(file)

    time_ago_in_words(file.split("academia_")[1].split(".backup")[0])
  end
  def get_name_from_backup(file)
    file.split("/").last
  end
end
