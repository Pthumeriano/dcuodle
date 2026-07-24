# Personagens não são semeados: vivem em data/characters/*.json.
#
# O único seed é o primeiro admin, e só quando ADMIN_PASSWORD está no ambiente — senha em
# arquivo versionado vira admin com senha conhecida em produção.
#
#   ADMIN_EMAIL=voce@exemplo.com ADMIN_PASSWORD=... bin/rails db:seed

if (password = ENV["ADMIN_PASSWORD"])
  user = User.find_or_initialize_by(email: ENV.fetch("ADMIN_EMAIL", "admin@dcdle.local"))
  user.password = password
  user.role = :admin
  user.save!
  puts "admin: #{user.email}"
end
