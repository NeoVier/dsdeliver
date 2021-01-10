[<CompilationRepresentation(CompilationRepresentationFlags.ModuleSuffix)>]
module Backend.Database

open FSharp.Data.Sql
open FSharp.Data.LiteralProviders

[<Literal>]
let private DbProvider = Common.DatabaseProviderTypes.POSTGRESQL

// type private Sql = SqlDataProvider<DbProvider, Env.BACKEND_URL.Value>
type private Sql = SqlDataProvider<DbProvider, "Host=localhost;Database=dsdeliver">

type ProductEntity = Sql.dataContext.``public.productEntity``
type OrderEntity = Sql.dataContext.``public.orderEntity``

type Context = Sql.dataContext

let context = Sql.GetDataContext Env.BACKEND_URL.Value
