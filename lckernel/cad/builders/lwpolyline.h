#pragma once

#include "cadentity.h"

namespace lc {
	namespace builder {

		struct LWBuilderVertex
		{
			LWBuilderVertex(geo::Coordinate v, double bul)
			{
				location = v;
				bulge = bul;
				startWidth = 0;
				endWidth = 0;
				hintAngle = 0;
				// Angle help to get start and end angle
				// It should be stored in entity too (for start and end vertices) since it's inverse calculation is harder
			}

			LWBuilderVertex(geo::Coordinate v, double startW, double endW, double bul, double hintAng)
			{
				location = v;
				startWidth = startW;
				endWidth = endW;
				bulge = bul;
				hintAngle = hintAng;
			}

			geo::Coordinate location;
			double bulge;
			double startWidth;
			double endWidth;
			double hintAngle;
		};

		class LWPolylineBuilder : public CADEntityBuilder {
			public:
				LWPolylineBuilder();

				virtual ~LWPolylineBuilder() = default;

				void addLineVertex(const lc::geo::Coordinate& vert);

				void addArcVertex(const lc::geo::Coordinate& vert);

				void modifyLastVertex(const geo::Coordinate& vert);

				void modifyLastVertexArc();

				void modifyLastVertexLine();

				void setWidth(double width);

				void removeVertex(int index);

				const std::vector<lc::builder::LWBuilderVertex>& getVertices();

                void setVertices(const std::vector<lc::builder::LWBuilderVertex>& builderVertices);

				lc::entity::LWPolyline_CSPtr build();

                double width() const;

                double elevation() const;

                double thickness() const;

                bool closed() const;

                lc::geo::Coordinate extrusionDirection() const;

                void copy(entity::LWPolyline_CSPtr entity);

		private:
			std::vector<lc::builder::LWBuilderVertex> _vertices;
			double _currentVertex_Bulge;
			double _currentVertex_StartWidth;
			double _currentVertex_EndWidth;

            double _width;
            double _elevation;
            double _thickness;
            bool _closed;
            lc::geo::Coordinate _extrusionDirection;
		};

	}
}
