[<CompilationRepresentation(CompilationRepresentationFlags.ModuleSuffix)>]
module Backend.Database

open FSharp.Data.Sql

[<Literal>]
let private Host = "localhost"

[<Literal>]
let private Database = "dsdeliver"

[<Literal>]
let private ConnectionString = "Host=" + Host + ";Database=" + Database

[<Literal>]
let private DbProvider = Common.DatabaseProviderTypes.POSTGRESQL

type private Sql = SqlDataProvider<DbProvider, ConnectionString>

type ProductEntity = Sql.dataContext.``public.productEntity``
type OrderEntity = Sql.dataContext.``public.orderEntity``

type Context = Sql.dataContext

let context = Sql.GetDataContext()
