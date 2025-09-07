abstract class Mapper<E, M> {
  E toEntity(M model);
  M toModel(E entity);

  List<E> toEntityList(List<M> models) => List.of(models.map((e) => toEntity(e)));
  List<M> toModelList(List<E> entities) => List.of(entities.map((e) => toModel(e)));
}
