using CadRestaurante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnRestaurante
{
    public class MesaCln
    {
        public static int insertar(Mesa mesa)
        {
            using (var context = new RestauranteEntities())
            {
                context.Mesa.Add(mesa);
                context.SaveChanges();
                return mesa.id;
            }
        }

        public static int actualizar(Mesa mesa)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Mesa.Find(mesa.id);
                existente.numMesa = mesa.numMesa;
                existente.usuarioRegistro = mesa.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Mesa.Find(id);
                existente.estado = -1;
                existente.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static Mesa get(int id)
        {
            using (var context = new RestauranteEntities())
            {
                return context.Mesa.Find(id);
            }
        }

        public static List<Mesa> listar()
        {
            using (var context = new RestauranteEntities())
            {
                return context.Mesa.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paMesaListar_Result> listarPa(string parametro)
        {
            using (var context = new RestauranteEntities())
            {
                return context.paMesaListar(parametro).ToList();
            }
        }
    }
}
