class Strength < ApplicationRecord
  extend Enumerize

  enumerize :nature, in: %w(ポジティブ 個別化 活発性 アレンジ 最上志向 着想 運命思考 社交性 調和性 共感性 包含 成長促進 達成欲 コミュニケーション 適応性 原点思考 内省 未来志向 学習欲 戦略性 親密性 自己確信 責任感 指令性 競争性 収集心 公平性 分析思考 回復志向 自我 目標志向 信念 規律性 慎重さ)

  belongs_to :user

  validates :nature, presence: {message: 'を選択してください'}

  CATEGORY = { '実行力の強み' => %w(アレンジ 回復志向 信念 規律性 慎重さ 責任感 達成欲 目標志向 公平性),
               '影響力の強み' => %w(活発性 競争性 コミュニケーション 最上志向 自我 自己確信 社交性 指令性),
               '人間関係構築力の強み' => %w(運命思考 共感性 個別化 親密性 成長促進 調和性 適応性 包含 ポジティブ),
               '戦略的思考力の強み' => %w(着想 原点思考 内省 未来志向 学習欲 戦略性 収集心 分析思考) }

  def color
    CATEGORY.each do |key, values|
      if values.include?(nature)
        return Strength.category_color(key)
      end
    end
    ''
  end

  def self.category_color(category)
    if category == '実行力の強み'
      return '#f6d5e0'
    elsif category == '影響力の強み'
      return '#feedd1'
    elsif category == '人間関係構築力の強み'
      return '#e2eeda'
    else
      return '#d7e5ff'
    end
  end
end
