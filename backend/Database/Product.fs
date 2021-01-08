module Backend.Database.Product

open Backend.Models

let internal productFromEntity (productEntity: ProductEntity): Product =
    { Name = productEntity.Name
      Description = productEntity.Description
      ImageUri = productEntity.ImageUri
      Price = productEntity.Price
      Id = productEntity.Id }

let allProducts (ctx: Context): Product [] =
    printfn $"Fetching all products"

    query {
        for product in ctx.Public.Product do
            sortBy (product.Name)
            select (product)
    }
    |> Seq.toArray
    |> Array.map productFromEntity