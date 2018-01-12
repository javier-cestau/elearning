class TypeSurvey< ApplicationRecord
  # Si se destruye el tipo de survey se destruye todos los survey que lo poseean
  has_many :surveys,  dependent: :destroy
end
