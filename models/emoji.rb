class Emoji
    attr_reader :emoji
    def initialize
        @emojis = %w(🎅 👯‍♀️ 💃 🦖 🐔 🥳 🧚 🧙‍♀️ 🐶 🐱 🐰 🦄 🦕 🌻 🌸 🌼 🌈 🌟 🌍 🍦 🥞 🍉 😸 🕺 🐨 🦧 🤶 🥂 🍻 🍭 💖)
        @emoji = @emojis.sample
    end
end