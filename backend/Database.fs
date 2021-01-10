[<CompilationRepresentation(CompilationRepresentationFlags.ModuleSuffix)>]
module Backend.Database

open FSharp.Data.Sql

[<Literal>]
let private DbProvider = Common.DatabaseProviderTypes.POSTGRESQL

type private Sql = SqlDataProvider<DbProvider, Env.BackendUrl>

type ProductEntity = Sql.dataContext.``public.productEntity``
type OrderEntity = Sql.dataContext.``public.orderEntity``

type Context = Sql.dataContext

let context = Sql.GetDataContext()
