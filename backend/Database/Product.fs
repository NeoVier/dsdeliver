module Backend.Database.Product

open Backend.Models

let internal productFromEntity (productEntity: ProductEntity): Product =
    { Name = productEntity.Name
      Description = productEntity.Description
      ImageUri = productEntity.ImageUri
      Price = productEntity.Price
      Id = productEntity.Id }

let allProducts: Product [] =
    query {
        for product in context.Public.Product do
            sortBy (product.Name)
            select (product)
    }
    |> Seq.toArray
    |> Array.map productFromEntity
