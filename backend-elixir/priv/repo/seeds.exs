# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Dsdeliver.Repo.insert!(%Dsdeliver.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Dsdeliver.Products.Product

Dsdeliver.Repo.insert!(%Product{
  name: "Macarrão Espaguete",
  price: 35.9,
  description: "Macarrão fresco espaguete com molho especial e tempero da casa.",
  image_uri:
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_espaguete.jpg"
})

Dsdeliver.Repo.insert!(%Product{
  name: "Macarrão Fusili",
  price: 38.0,
  description: "Macarrão fusili com toque do chef e especiarias.",
  image_uri:
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_fusili.jpg"
})

Dsdeliver.Repo.insert!(%Product{
  name: "Macarrão Penne",
  price: 37.9,
  description: "Macarrão penne fresco ao dente com tempero especial.",
  image_uri: "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/macarrao_penne.jpg"
})

Dsdeliver.Repo.insert!(%Product{
  name: "Pizza Bacon",
  price: 49.9,
  description: "Pizza de bacon com mussarela, orégano, molho especial e tempero da casa.",
  image_uri: "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_bacon.jpg"
})

Dsdeliver.Repo.insert!(%Product{
  name: "Pizza Moda da Casa",
  price: 59.9,
  description:
    "Pizza à moda da casa, com molho especial e todos ingredientes básicos, e queijo à sua escolha.",
  image_uri: "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_moda.jpg"
})

Dsdeliver.Repo.insert!(%Product{
  name: "Pizza Portuguesa",
  price: 45.0,
  description: "Pizza Portuguesa com molho especial, mussarela, presunto, ovos e especiarias.",
  image_uri:
    "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/pizza_portuguesa.jpg"
})

Dsdeliver.Repo.insert!(%Product{
  name: "Risoto de Carne",
  price: 52.0,
  description: "Risoto de carne com especiarias e um delicioso molho de acompanhamento.",
  image_uri: "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/risoto_carne.jpg"
})

Dsdeliver.Repo.insert!(%Product{
  name: "Risoto Funghi",
  price: 59.95,
  description: "Risoto Funghi feito com ingredientes finos e o toque especial do chef.",
  image_uri: "https://raw.githubusercontent.com/devsuperior/sds2/master/assets/risoto_funghi.jpg"
})
