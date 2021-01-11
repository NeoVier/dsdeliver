[<CompilationRepresentation(CompilationRepresentationFlags.ModuleSuffix)>]
module Backend.Database

open FSharp.Data.Sql
open FSharp.Data.LiteralProviders

[<Literal>]
let private DbProvider = Common.DatabaseProviderTypes.POSTGRESQL

type private Sql = SqlDataProvider<DbProvider, "Host=localhost;Database=dsdeliver">

type ProductEntity = Sql.dataContext.``public.productEntity``
type OrderEntity = Sql.dataContext.``public.orderEntity``

type Context = Sql.dataContext

let context =
    Sql.GetDataContext Env.DATABASE_URL.Value

// let context =
//     Sql.GetDataContext
//         "postgres://haartzajgwdyau:0c30e8b4e8ede21e95c71f066ede7b2841641e7205463f1396a008c7ce409992@ec2-52-5-176-53.compute-1.amazonaws.com:5432/d76jhfa9d0d21h"
