module Backend.Database.Product

open Backend.Database
open Backend.Models

let internal fromEntity (productEntity: ProductEntity): Product =
    { Name = productEntity.Name
      Description = productEntity.Description
      ImageUri = productEntity.ImageUri
      Price = productEntity.Price
      Id = productEntity.Id }
