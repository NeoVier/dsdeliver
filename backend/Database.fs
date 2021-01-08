[<CompilationRepresentation(CompilationRepresentationFlags.ModuleSuffix)>]
module Backend.Database

open FSharp.Data.Sql

[<Literal>]
let internal Host = "localhost"

[<Literal>]
let internal Database = "dsdeliver"

[<Literal>]
let internal ConnectionString = "Host=" + Host + ";Database=" + Database

[<Literal>]
let internal DbProvider = Common.DatabaseProviderTypes.POSTGRESQL

type internal Sql = SqlDataProvider<DbProvider, ConnectionString>

type ProductEntity = Sql.dataContext.``public.productEntity``
type OrderEntity = Sql.dataContext.``public.orderEntity``

let ctx = Sql.GetDataContext()
