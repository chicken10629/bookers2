class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      #デフォ画像のパス・ファイル名・ファイル拡張子を指定
      #画像を登録するけど、したにelseをいれてしまっていたため、画像表示しないよ？になっていた
    end

    profile_image.variant(resize_to_limit: [100, 100]).processed
    #画像表示処理なので、どのパターンでもつかう。
    #プロフ画像は縦横比を維持しながら、縦横大きい方を100pxにしているようだ　小さい方は当然100px未満となる
    #リサイズするにはImageMazickが必須なのでインストールする必要があるが、済んでいた
  end
end
